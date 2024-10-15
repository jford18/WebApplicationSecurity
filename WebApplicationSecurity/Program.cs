using WebApplicationSecurity.Data;

var builder = WebApplication.CreateBuilder(args);

// Agregar servicios de sesión
builder.Services.AddDistributedMemoryCache();
builder.Services.AddSession(options =>
{
    options.IdleTimeout = TimeSpan.FromMinutes(30); // Duración de la sesión
    options.Cookie.HttpOnly = true; // Solo cookies HTTP
    options.Cookie.IsEssential = true; // Necesario para la sesión
});

builder.Services.AddScoped<DataAccess>(); // Registro como Scoped

// Agregar servicios de controlador
builder.Services.AddControllersWithViews();

var app = builder.Build();

// Configure the HTTP request pipeline.
if (!app.Environment.IsDevelopment())
{
    app.UseExceptionHandler("/Home/Error");
    app.UseHsts();
}

app.UseHttpsRedirection();
app.UseStaticFiles();

app.UseRouting();

// Agregar el middleware de sesión aquí
app.UseSession(); // <<--- IMPORTANTE: Esto habilita el manejo de sesiones

app.UseAuthorization();

app.MapControllerRoute(
    name: "default",
    pattern: "{controller=Auth}/{action=Login}/{id?}");

app.Run();
