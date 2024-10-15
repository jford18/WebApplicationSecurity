using System;
using System.Collections.Generic;
using System.Data;
using Microsoft.Extensions.Configuration;

using System.Data.SqlClient;

namespace WebApplicationSecurity.Data
{
    public class DataAccess
    {
        private readonly string _connectionString;

        public DataAccess(IConfiguration configuration)
        {
            _connectionString = configuration.GetConnectionString("DefaultConnection");
        }
        public DataTable GetRolesByUserId(int usuarioId)
        {
            var query = $"SELECT r.RolName FROM rol_usuarios ru INNER JOIN Rol r ON ru.Rol_idRol = r.idRol WHERE ru.usuarios_idUsuario = {usuarioId}";
            return ExecuteQuery(query);
        }
        public void UpdatePersona(int idPersona, string nombres, string apellidos, string identificacion, DateTime fechaNacimiento)
        {
            var parameters = new List<SqlParameter>
    {
        new SqlParameter("@idPersona", idPersona),
        new SqlParameter("@Nombres", nombres),
        new SqlParameter("@Apellidos", apellidos),
        new SqlParameter("@Identificacion", identificacion),
        new SqlParameter("@FechaNacimiento", fechaNacimiento)
    };

            ExecuteStoredProcedure("sp_UpdatePersona", parameters);
        }



        public DataRow GetUsuarioById(int idUsuario)
        {
            var query = $"SELECT * FROM usuarios WHERE idUsuario = {idUsuario}";

            DataTable result = ExecuteQuery(query);

            if (result.Rows.Count > 0)
            {
                return result.Rows[0];
            }

            return null; // Si no se encuentra el usuario, devolver null
        }

        public DataRow GetUsuarioById2(int idUsuario)
        {
            var query = $@"
        SELECT 
            u.idUsuario, 
            u.UserName, 
            u.Mail, 
            u.Password, 
            u.Status, 
            u.SessionActive, 
            p.Nombres, 
            p.Apellidos, 
            p.Identificacion, 
            p.FechaNacimiento,
            r.idRol, 
            r.RolName
        FROM usuarios u
        INNER JOIN Persona p ON u.Persona_idPersona2 = p.idPersona
        INNER JOIN rol_usuarios ru ON u.idUsuario = ru.usuarios_idUsuario
        INNER JOIN Rol r ON ru.Rol_idRol = r.idRol
        WHERE u.idUsuario = {idUsuario}";

            DataTable result = ExecuteQuery(query);
            if (result.Rows.Count > 0)
            {
                return result.Rows[0];
            }

            return null; // Si no se encuentra el usuario, devolver null
        }


        // Método genérico para ejecutar un procedimiento almacenado (Stored Procedure)
        public void ExecuteStoredProcedure(string storedProcedureName, List<SqlParameter> parameters)
        {
            using (SqlConnection conn = new SqlConnection(_connectionString))
            {
                using (SqlCommand cmd = new SqlCommand(storedProcedureName, conn))
                {
                    cmd.CommandType = CommandType.StoredProcedure;

                    // Agregar los parámetros
                    if (parameters != null)
                    {
                        foreach (var param in parameters)
                        {
                            cmd.Parameters.Add(param);
                        }
                    }

                    conn.Open();
                    cmd.ExecuteNonQuery();
                }
            }
        }

        // Método para ejecutar consultas y obtener datos
        public DataTable ExecuteQuery(string query)
        {
            DataTable result = new DataTable();

            using (SqlConnection conn = new SqlConnection(_connectionString))
            {
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    conn.Open();

                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        result.Load(reader);
                    }
                }
            }

            return result;
        }

        // Método para insertar un usuario
        public void InsertUsuario(string nombres, string apellidos, string identificacion, DateTime fechaNacimiento, string userName, string password, string mail, string status, int rolId)
        {
            var parameters = new List<SqlParameter>
    {
        new SqlParameter("@Nombres", nombres),
        new SqlParameter("@Apellidos", apellidos),
        new SqlParameter("@Identificacion", identificacion),
        new SqlParameter("@FechaNacimiento", fechaNacimiento),
        new SqlParameter("@UserName", userName),
        new SqlParameter("@Password", password),
        new SqlParameter("@Mail", mail),
        new SqlParameter("@Status", status),
        new SqlParameter("@RolId", rolId)
    };

            ExecuteStoredProcedure("sp_InsertUsuario", parameters);
        }


        // Método para obtener todos los usuarios
        public DataTable GetUsuarios()
        {
            return ExecuteQuery("EXEC sp_GetUsuarios");
        }

        // Método para actualizar un usuario
        public void UpdateUsuario(int idUsuario, string userName, string mail, string status)
        {
            var parameters = new List<SqlParameter>
            {
                new SqlParameter("@idUsuario", idUsuario),
                new SqlParameter("@UserName", userName),
                new SqlParameter("@Mail", mail),
                new SqlParameter("@Status", status)
            };

            ExecuteStoredProcedure("sp_UpdateUsuario", parameters);
        }
        public void UpdateUsuario2(int idUsuario, string userName, string password, string mail, string status, int rolId)
        {
            var parameters = new List<SqlParameter>
    {
        new SqlParameter("@idUsuario", idUsuario),
        new SqlParameter("@UserName", userName),
        new SqlParameter("@Password", password),
        new SqlParameter("@Mail", mail),
        new SqlParameter("@Status", status),
        new SqlParameter("@RolId", rolId)
    };

            ExecuteStoredProcedure("sp_UpdateUsuario", parameters);
        }


        // Método para eliminar lógicamente a un usuario
        public void DeleteUsuario(int idUsuario)
        {
            var parameters = new List<SqlParameter>
            {
                new SqlParameter("@idUsuario", idUsuario)
            };

            ExecuteStoredProcedure("sp_DeleteUsuario", parameters);
        }

        // Método para insertar un rol
        public void InsertRol(string rolName)
        {
            var parameters = new List<SqlParameter>
            {
                new SqlParameter("@RolName", rolName)
            };

            ExecuteStoredProcedure("sp_InsertRol", parameters);
        }

        // Método para asignar un rol a un usuario
        public void AssignRolToUsuario(int rolId, int usuarioId)
        {
            var parameters = new List<SqlParameter>
            {
                new SqlParameter("@Rol_idRol", rolId),
                new SqlParameter("@usuarios_idUsuario", usuarioId)
            };

            ExecuteStoredProcedure("sp_AssignRolToUsuario", parameters);
        }

        // Método para obtener todos los roles
        public DataTable GetRoles()
        {
            return ExecuteQuery("SELECT * FROM Rol");
        }

        // Método para obtener las opciones asignadas a un rol
        public DataTable GetOpcionesByRol(int rolId)
        {
            var query = $"SELECT * FROM RolOpciones ro INNER JOIN rol_rolOpciones rro ON ro.idOpcion = rro.RolOpciones_idOpcion WHERE rro.Rol_idRol = {rolId}";
            return ExecuteQuery(query);
        }

        // Método para registrar una sesión de usuario
        public void InsertSession(DateTime fechaIngreso, int usuarioId)
        {
            var parameters = new List<SqlParameter>
            {
                new SqlParameter("@FechaIngreso", fechaIngreso),
                new SqlParameter("@usuarios_idUsuario", usuarioId)
            };

            ExecuteStoredProcedure("sp_InsertSession", parameters);
        }

        // Método para cerrar una sesión de usuario
        public void CloseSession(DateTime fechaCierre, int usuarioId)
        {
            var parameters = new List<SqlParameter>
            {
                new SqlParameter("@FechaCierre", fechaCierre),
                new SqlParameter("@usuarios_idUsuario", usuarioId)
            };

            ExecuteStoredProcedure("sp_CloseSession", parameters);
        }

        // Método para obtener sesiones de usuario
        public DataTable GetUserSessions(int usuarioId)
        {
            var query = $"SELECT * FROM Sessions WHERE usuarios_idUsuario = {usuarioId}";
            return ExecuteQuery(query);
        }
    }
}
