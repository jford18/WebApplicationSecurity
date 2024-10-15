using Microsoft.AspNetCore.Mvc;
using System.Data;
using System.Data.SqlClient;
using WebApplicationSecurity.Data;

public class AuthController : Controller
{
    private readonly DataAccess _dataAccess;

    public AuthController(DataAccess dataAccess)
    {
        _dataAccess = dataAccess;
    }

    [HttpGet]
    public IActionResult Login()
    {
        return View();
    }
    
    [HttpPost]
    public IActionResult Login(string usernameOrEmail, string password)
    {
        // Verificar si existe el usuario por nombre o correo
        var user = _dataAccess.GetUsuarios()
                    .AsEnumerable()
                    .FirstOrDefault(u => (u["UserName"].ToString() == usernameOrEmail || u["Mail"].ToString() == usernameOrEmail)
                                          && u["Password"].ToString() == password);

        if (user == null)
        {
            ViewBag.Message = "Usuario o contraseña incorrecta";
            return View();
        }

        // Validar que el usuario no esté bloqueado
        if (user["Status"].ToString() == "Blocked")
        {
            ViewBag.Message = "Usuario bloqueado.";
            return View();
        }

        // Aquí obtienes el rol del usuario (consultando la tabla rol_usuarios)
        var userRoles = _dataAccess.GetRolesByUserId(Convert.ToInt32(user["idUsuario"])); // Obtener roles del usuario
        var roleName = userRoles.Rows[0]["RolName"].ToString(); // Suponiendo que obtienes el rol en esta columna

        // Almacenar el rol en la sesión
        _dataAccess.InsertSession(DateTime.Now, Convert.ToInt32(user["idUsuario"])); 

        HttpContext.Session.SetInt32("UsuarioId", Convert.ToInt32(user["idUsuario"]));

        // Registrar la sesión en la base de datos
        

        if (roleName == "Admin")
        {
            return RedirectToAction("Index", "Usuario"); // Redirige al mantenimiento de usuario
        }
        else
        {
            return RedirectToAction("Welcome", "Dashboard"); // Redirige al Dashboard para usuarios estándar
        }

    }



    [HttpPost]
    public IActionResult Logout()
    {
        var usuarioId = HttpContext.Session.GetInt32("UsuarioId");
        if (usuarioId.HasValue)
        {
            _dataAccess.CloseSession(DateTime.Now, usuarioId.Value);
            HttpContext.Session.Clear(); // Limpiar la sesión
        }
        return RedirectToAction("Login");
    }

}
