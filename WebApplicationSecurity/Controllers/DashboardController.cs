using Microsoft.AspNetCore.Mvc;
using WebApplicationSecurity.Data;

public class DashboardController : Controller
{
    private readonly DataAccess _dataAccess;

    public DashboardController(DataAccess dataAccess)
    {
        _dataAccess = dataAccess;
    }

    [HttpGet]
    public IActionResult Welcome()
    {
        var usuarioId = HttpContext.Session.GetInt32("UsuarioId");
        var sesiones = _dataAccess.GetUserSessions(usuarioId.Value);

        return View(sesiones);
    }

    [HttpGet]
    public IActionResult AdminDashboard()
    {
        var role = HttpContext.Session.GetString("UserRole");

        if (role != "Admin")
        {
            return RedirectToAction("AccessDenied", "Home");
        }

        var usuarios = _dataAccess.GetUsuarios();
        return View(usuarios);
    }

}
