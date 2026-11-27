import os
from contextlib import contextmanager
from datetime import datetime, timedelta, timezone
from typing import Optional

import bcrypt
import jwt
import psycopg2
from fastapi import Depends, FastAPI, HTTPException
from fastapi.security import HTTPAuthorizationCredentials, HTTPBearer
from psycopg2.extras import RealDictCursor
from pydantic import BaseModel

DB = {
    "host": "localhost",
    "port": 5432,
    "dbname": "taskschool",
    "user": "postgres",
    "password": os.getenv("DB_PASSWORD", "210504"),
}
SECRET = os.getenv("JWT_SECRET", "cambia-esta-clave")
ALGORITMO = "HS256"

app = FastAPI(title="TaskSchool API")
seguridad = HTTPBearer()


@contextmanager
def cursor():
    con = psycopg2.connect(**DB, cursor_factory=RealDictCursor)
    try:
        with con:
            with con.cursor() as cur:
                yield cur
    finally:
        con.close()


class Credenciales(BaseModel):
    correo: str
    password: str


class TareaIn(BaseModel):
    titulo: str
    prioridad: str = "Media"
    hecha: bool = False
    fecha_limite: Optional[str] = None


class MateriaIn(BaseModel):
    nivel: str
    materia: str
    completada: bool


def crear_token(usuario_id: int) -> str:
    datos = {
        "sub": str(usuario_id),
        "exp": datetime.now(timezone.utc) + timedelta(days=7),
    }
    return jwt.encode(datos, SECRET, algorithm=ALGORITMO)


def usuario_actual(
    cred: HTTPAuthorizationCredentials = Depends(seguridad),
) -> int:
    try:
        datos = jwt.decode(cred.credentials, SECRET, algorithms=[ALGORITMO])
        return int(datos["sub"])
    except Exception:
        raise HTTPException(status_code=401, detail="Sesión no válida")


@app.post("/registro")
def registro(c: Credenciales):
    correo = c.correo.strip().lower()
    if len(c.password) < 6:
        raise HTTPException(400, "La contraseña debe tener al menos 6 caracteres")
    hash_ = bcrypt.hashpw(c.password.encode(), bcrypt.gensalt()).decode()
    with cursor() as cur:
        cur.execute("SELECT id FROM usuarios WHERE correo = %s", (correo,))
        if cur.fetchone():
            raise HTTPException(409, "Ese correo ya está registrado")
        cur.execute(
            "INSERT INTO usuarios (correo, password_hash) "
            "VALUES (%s, %s) RETURNING id",
            (correo, hash_),
        )
        nuevo = cur.fetchone()
    return {"token": crear_token(nuevo["id"])}


@app.post("/login")
def login(c: Credenciales):
    correo = c.correo.strip().lower()
    with cursor() as cur:
        cur.execute(
            "SELECT id, password_hash FROM usuarios WHERE correo = %s", (correo,)
        )
        fila = cur.fetchone()
    if not fila or not bcrypt.checkpw(
        c.password.encode(), fila["password_hash"].encode()
    ):
        raise HTTPException(401, "Correo o contraseña incorrectos")
    return {"token": crear_token(fila["id"])}


@app.get("/tareas")
def listar_tareas(uid: int = Depends(usuario_actual)):
    with cursor() as cur:
        cur.execute(
            "SELECT id, titulo, prioridad, hecha, fecha_limite "
            "FROM tareas WHERE usuario_id = %s ORDER BY id",
            (uid,),
        )
        return cur.fetchall()


@app.post("/tareas")
def crear_tarea(t: TareaIn, uid: int = Depends(usuario_actual)):
    if t.prioridad not in ("Alta", "Media", "Baja"):
        raise HTTPException(400, "Prioridad no válida")
    with cursor() as cur:
        cur.execute(
            "INSERT INTO tareas (usuario_id, titulo, prioridad, hecha, fecha_limite) "
            "VALUES (%s, %s, %s, %s, %s) "
            "RETURNING id, titulo, prioridad, hecha, fecha_limite",
            (uid, t.titulo, t.prioridad, t.hecha, t.fecha_limite),
        )
        return cur.fetchone()


@app.put("/tareas/{tarea_id}")
def actualizar_tarea(
    tarea_id: int, t: TareaIn, uid: int = Depends(usuario_actual)
):
    with cursor() as cur:
        cur.execute(
            "UPDATE tareas SET titulo = %s, prioridad = %s, hecha = %s, "
            "fecha_limite = %s WHERE id = %s AND usuario_id = %s",
            (t.titulo, t.prioridad, t.hecha, t.fecha_limite, tarea_id, uid),
        )
        if cur.rowcount == 0:
            raise HTTPException(404, "Tarea no encontrada")
    return {"ok": True}


@app.delete("/tareas/{tarea_id}")
def eliminar_tarea(tarea_id: int, uid: int = Depends(usuario_actual)):
    with cursor() as cur:
        cur.execute(
            "DELETE FROM tareas WHERE id = %s AND usuario_id = %s",
            (tarea_id, uid),
        )
        if cur.rowcount == 0:
            raise HTTPException(404, "Tarea no encontrada")
    return {"ok": True}


@app.get("/materias")
def listar_materias(uid: int = Depends(usuario_actual)):
    with cursor() as cur:
        cur.execute(
            "SELECT nivel, materia FROM materias_completadas WHERE usuario_id = %s",
            (uid,),
        )
        return cur.fetchall()


@app.put("/materias")
def marcar_materia(m: MateriaIn, uid: int = Depends(usuario_actual)):
    with cursor() as cur:
        if m.completada:
            cur.execute(
                "INSERT INTO materias_completadas (usuario_id, nivel, materia) "
                "VALUES (%s, %s, %s) ON CONFLICT DO NOTHING",
                (uid, m.nivel, m.materia),
            )
        else:
            cur.execute(
                "DELETE FROM materias_completadas "
                "WHERE usuario_id = %s AND nivel = %s AND materia = %s",
                (uid, m.nivel, m.materia),
            )
    return {"ok": True}