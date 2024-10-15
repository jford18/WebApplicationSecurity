using Microsoft.AspNetCore.Mvc;
using WebApplicationSecurity.Data;
using System.Linq;
using System.Data;
using OfficeOpenXml;

public class UsuarioController : Controller
{
    private readonly DataAccess _dataAccess;

    public UsuarioController(DataAccess dataAccess)
    {
        _dataAccess = dataAccess;
    }

    // Acción para cargar la lista de usuarios y aplicar filtro de búsqueda

    public IActionResult Index(string searchTerm = "")
    {
        var usuarios = _dataAccess.GetUsuarios();

        if (!string.IsNullOrEmpty(searchTerm))
        {
            usuarios = usuarios.AsEnumerable()
                .Where(u => u["UserName"].ToString().Contains(searchTerm) || u["Mail"].ToString().Contains(searchTerm))
                .CopyToDataTable();
        }

        return View(usuarios);
    }

    // Acción para editar los datos de un usuario
    [HttpGet]
    public IActionResult Edit(int id)
    {
        var usuario = _dataAccess.GetUsuarioById2(id);
        return View(usuario);
    }

    [HttpPost]
    public IActionResult Edit(int id, string nombres, string apellidos, string identificacion, DateTime fechaNacimiento, string userName, string password, string mail, string status, int rolId)
    {
        // Actualizar la tabla Persona
        _dataAccess.UpdatePersona(id, nombres, apellidos, identificacion, fechaNacimiento);

        // Actualizar la tabla Usuarios
        _dataAccess.UpdateUsuario2(id, userName, password, mail, status, rolId);

        return RedirectToAction("Index");
    }



    // Acción para cambiar el estado de un usuario (solo administrador)
    [HttpGet]
    public IActionResult ChangeStatus(int id)
    {
        var usuario = _dataAccess.GetUsuarioById(id);
        if (usuario["Status"].ToString() == "Active")
        {
            _dataAccess.UpdateUsuario(id, usuario["UserName"].ToString(), usuario["Mail"].ToString(), "Inactive");
        }
        else
        {
            _dataAccess.UpdateUsuario(id, usuario["UserName"].ToString(), usuario["Mail"].ToString(), "Active");
        }

        return RedirectToAction("Index");
    }


   [HttpPost]
public IActionResult UploadUsersFromCsv(IFormFile file)
{
    if (file != null && file.Length > 0)
    {
        using (var reader = new StreamReader(file.OpenReadStream()))
        {
            while (!reader.EndOfStream)
            {
                var line = reader.ReadLine();
                var values = line.Split(',');

                string nombres = values[0];
                string apellidos = values[1];
                string identificacion = values[2];
                DateTime fechaNacimiento = DateTime.Parse(values[3]);
                string userName = values[4];
                string password = values[5];
                string mail = values[6];
                string status = values[7];
                int rolId = int.Parse(values[8]);

                // Insertar el usuario en la base de datos
                _dataAccess.InsertUsuario(nombres, apellidos, identificacion, fechaNacimiento, userName, password, mail, status, rolId);
            }
        }
    }

    return RedirectToAction("Index");
}


    // Método para cargar usuarios masivamente desde un archivo (solo administrador)

}
