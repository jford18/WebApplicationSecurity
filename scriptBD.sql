USE [DBSECURITY]
GO
/****** Object:  StoredProcedure [dbo].[sp_UpdateUsuario]    Script Date: 15/10/2024 15:16:47 ******/
DROP PROCEDURE [dbo].[sp_UpdateUsuario]
GO
/****** Object:  StoredProcedure [dbo].[sp_UpdatePersona]    Script Date: 15/10/2024 15:16:47 ******/
DROP PROCEDURE [dbo].[sp_UpdatePersona]
GO
/****** Object:  StoredProcedure [dbo].[sp_InsertUsuario]    Script Date: 15/10/2024 15:16:47 ******/
DROP PROCEDURE [dbo].[sp_InsertUsuario]
GO
/****** Object:  StoredProcedure [dbo].[sp_InsertSession]    Script Date: 15/10/2024 15:16:47 ******/
DROP PROCEDURE [dbo].[sp_InsertSession]
GO
/****** Object:  StoredProcedure [dbo].[sp_InsertRol]    Script Date: 15/10/2024 15:16:47 ******/
DROP PROCEDURE [dbo].[sp_InsertRol]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetUsuarios]    Script Date: 15/10/2024 15:16:47 ******/
DROP PROCEDURE [dbo].[sp_GetUsuarios]
GO
/****** Object:  StoredProcedure [dbo].[sp_DeleteUsuario]    Script Date: 15/10/2024 15:16:47 ******/
DROP PROCEDURE [dbo].[sp_DeleteUsuario]
GO
/****** Object:  StoredProcedure [dbo].[sp_AssignRolToUsuario]    Script Date: 15/10/2024 15:16:47 ******/
DROP PROCEDURE [dbo].[sp_AssignRolToUsuario]
GO
ALTER TABLE [dbo].[usuarios] DROP CONSTRAINT [FK__usuarios__Person__3B75D760]
GO
ALTER TABLE [dbo].[Sessions] DROP CONSTRAINT [FK__Sessions__usuari__48CFD27E]
GO
ALTER TABLE [dbo].[rol_usuarios] DROP CONSTRAINT [FK__rol_usuar__usuar__4316F928]
GO
ALTER TABLE [dbo].[rol_usuarios] DROP CONSTRAINT [FK__rol_usuar__Rol_i__4222D4EF]
GO
ALTER TABLE [dbo].[rol_rolOpciones] DROP CONSTRAINT [FK__rol_rolOp__RolOp__46E78A0C]
GO
ALTER TABLE [dbo].[rol_rolOpciones] DROP CONSTRAINT [FK__rol_rolOp__Rol_i__45F365D3]
GO
ALTER TABLE [dbo].[usuarios] DROP CONSTRAINT [DF__usuarios__Status__3A81B327]
GO
ALTER TABLE [dbo].[usuarios] DROP CONSTRAINT [DF__usuarios__Sessio__398D8EEE]
GO
/****** Object:  Table [dbo].[usuarios]    Script Date: 15/10/2024 15:16:47 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usuarios]') AND type in (N'U'))
DROP TABLE [dbo].[usuarios]
GO
/****** Object:  Table [dbo].[Sessions]    Script Date: 15/10/2024 15:16:47 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Sessions]') AND type in (N'U'))
DROP TABLE [dbo].[Sessions]
GO
/****** Object:  Table [dbo].[RolOpciones]    Script Date: 15/10/2024 15:16:47 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[RolOpciones]') AND type in (N'U'))
DROP TABLE [dbo].[RolOpciones]
GO
/****** Object:  Table [dbo].[rol_usuarios]    Script Date: 15/10/2024 15:16:47 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[rol_usuarios]') AND type in (N'U'))
DROP TABLE [dbo].[rol_usuarios]
GO
/****** Object:  Table [dbo].[rol_rolOpciones]    Script Date: 15/10/2024 15:16:47 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[rol_rolOpciones]') AND type in (N'U'))
DROP TABLE [dbo].[rol_rolOpciones]
GO
/****** Object:  Table [dbo].[Rol]    Script Date: 15/10/2024 15:16:47 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Rol]') AND type in (N'U'))
DROP TABLE [dbo].[Rol]
GO
/****** Object:  Table [dbo].[Persona]    Script Date: 15/10/2024 15:16:47 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Persona]') AND type in (N'U'))
DROP TABLE [dbo].[Persona]
GO
/****** Object:  Table [dbo].[Persona]    Script Date: 15/10/2024 15:16:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Persona](
	[idPersona] [int] IDENTITY(1,1) NOT NULL,
	[Nombres] [varchar](60) NOT NULL,
	[Apellidos] [varchar](60) NOT NULL,
	[Identificacion] [varchar](10) NOT NULL,
	[FechaNacimiento] [date] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[idPersona] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Rol]    Script Date: 15/10/2024 15:16:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Rol](
	[idRol] [int] IDENTITY(1,1) NOT NULL,
	[RolName] [varchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[idRol] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[rol_rolOpciones]    Script Date: 15/10/2024 15:16:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[rol_rolOpciones](
	[Rol_idRol] [int] NOT NULL,
	[RolOpciones_idOpcion] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Rol_idRol] ASC,
	[RolOpciones_idOpcion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[rol_usuarios]    Script Date: 15/10/2024 15:16:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[rol_usuarios](
	[Rol_idRol] [int] NOT NULL,
	[usuarios_idUsuario] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Rol_idRol] ASC,
	[usuarios_idUsuario] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RolOpciones]    Script Date: 15/10/2024 15:16:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RolOpciones](
	[idOpcion] [int] IDENTITY(1,1) NOT NULL,
	[NombreOpcion] [varchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[idOpcion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Sessions]    Script Date: 15/10/2024 15:16:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Sessions](
	[FechaIngreso] [date] NOT NULL,
	[FechaCierre] [date] NULL,
	[usuarios_idUsuario] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[usuarios]    Script Date: 15/10/2024 15:16:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[usuarios](
	[idUsuario] [int] IDENTITY(1,1) NOT NULL,
	[UserName] [varchar](50) NOT NULL,
	[Password] [varchar](50) NOT NULL,
	[Mail] [varchar](120) NOT NULL,
	[SessionActive] [char](1) NULL,
	[Persona_idPersona2] [int] NULL,
	[Status] [char](20) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[idUsuario] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Persona] ON 
GO
INSERT [dbo].[Persona] ([idPersona], [Nombres], [Apellidos], [Identificacion], [FechaNacimiento]) VALUES (1, N'Juan Alberto', N'Piguave 2', N'1203574901', CAST(N'1990-05-15' AS Date))
GO
INSERT [dbo].[Persona] ([idPersona], [Nombres], [Apellidos], [Identificacion], [FechaNacimiento]) VALUES (9, N'"Maria"', N'"Smith Lopez"', N'1203574902', CAST(N'1992-10-25' AS Date))
GO
INSERT [dbo].[Persona] ([idPersona], [Nombres], [Apellidos], [Identificacion], [FechaNacimiento]) VALUES (10, N'"Michael"', N'"Jones Perez"', N'1203574903', CAST(N'1985-07-12' AS Date))
GO
SET IDENTITY_INSERT [dbo].[Persona] OFF
GO
SET IDENTITY_INSERT [dbo].[Rol] ON 
GO
INSERT [dbo].[Rol] ([idRol], [RolName]) VALUES (1, N'Admin')
GO
INSERT [dbo].[Rol] ([idRol], [RolName]) VALUES (2, N'User')
GO
SET IDENTITY_INSERT [dbo].[Rol] OFF
GO
INSERT [dbo].[rol_usuarios] ([Rol_idRol], [usuarios_idUsuario]) VALUES (1, 1)
GO
INSERT [dbo].[rol_usuarios] ([Rol_idRol], [usuarios_idUsuario]) VALUES (2, 9)
GO
INSERT [dbo].[rol_usuarios] ([Rol_idRol], [usuarios_idUsuario]) VALUES (2, 10)
GO
INSERT [dbo].[Sessions] ([FechaIngreso], [FechaCierre], [usuarios_idUsuario]) VALUES (CAST(N'2024-10-14' AS Date), NULL, 1)
GO
INSERT [dbo].[Sessions] ([FechaIngreso], [FechaCierre], [usuarios_idUsuario]) VALUES (CAST(N'2024-10-14' AS Date), NULL, 1)
GO
INSERT [dbo].[Sessions] ([FechaIngreso], [FechaCierre], [usuarios_idUsuario]) VALUES (CAST(N'2024-10-14' AS Date), NULL, 1)
GO
INSERT [dbo].[Sessions] ([FechaIngreso], [FechaCierre], [usuarios_idUsuario]) VALUES (CAST(N'2024-10-14' AS Date), NULL, 1)
GO
INSERT [dbo].[Sessions] ([FechaIngreso], [FechaCierre], [usuarios_idUsuario]) VALUES (CAST(N'2024-10-15' AS Date), NULL, 10)
GO
INSERT [dbo].[Sessions] ([FechaIngreso], [FechaCierre], [usuarios_idUsuario]) VALUES (CAST(N'2024-10-15' AS Date), NULL, 1)
GO
INSERT [dbo].[Sessions] ([FechaIngreso], [FechaCierre], [usuarios_idUsuario]) VALUES (CAST(N'2024-10-15' AS Date), NULL, 1)
GO
INSERT [dbo].[Sessions] ([FechaIngreso], [FechaCierre], [usuarios_idUsuario]) VALUES (CAST(N'2024-10-15' AS Date), NULL, 1)
GO
INSERT [dbo].[Sessions] ([FechaIngreso], [FechaCierre], [usuarios_idUsuario]) VALUES (CAST(N'2024-10-15' AS Date), NULL, 1)
GO
INSERT [dbo].[Sessions] ([FechaIngreso], [FechaCierre], [usuarios_idUsuario]) VALUES (CAST(N'2024-10-14' AS Date), NULL, 1)
GO
INSERT [dbo].[Sessions] ([FechaIngreso], [FechaCierre], [usuarios_idUsuario]) VALUES (CAST(N'2024-10-14' AS Date), NULL, 1)
GO
INSERT [dbo].[Sessions] ([FechaIngreso], [FechaCierre], [usuarios_idUsuario]) VALUES (CAST(N'2024-10-14' AS Date), NULL, 10)
GO
INSERT [dbo].[Sessions] ([FechaIngreso], [FechaCierre], [usuarios_idUsuario]) VALUES (CAST(N'2024-10-14' AS Date), NULL, 10)
GO
INSERT [dbo].[Sessions] ([FechaIngreso], [FechaCierre], [usuarios_idUsuario]) VALUES (CAST(N'2024-10-14' AS Date), NULL, 1)
GO
INSERT [dbo].[Sessions] ([FechaIngreso], [FechaCierre], [usuarios_idUsuario]) VALUES (CAST(N'2024-10-14' AS Date), NULL, 1)
GO
INSERT [dbo].[Sessions] ([FechaIngreso], [FechaCierre], [usuarios_idUsuario]) VALUES (CAST(N'2024-10-15' AS Date), NULL, 1)
GO
SET IDENTITY_INSERT [dbo].[usuarios] ON 
GO
INSERT [dbo].[usuarios] ([idUsuario], [UserName], [Password], [Mail], [SessionActive], [Persona_idPersona2], [Status]) VALUES (1, N'jpiguavel', N'1', N'jpiguavel@mail.com', N'N', 1, N'I                   ')
GO
INSERT [dbo].[usuarios] ([idUsuario], [UserName], [Password], [Mail], [SessionActive], [Persona_idPersona2], [Status]) VALUES (9, N'msmith', N'SecurePass1', N'msmith@mail.com', N'N', 9, N'Inactive            ')
GO
INSERT [dbo].[usuarios] ([idUsuario], [UserName], [Password], [Mail], [SessionActive], [Persona_idPersona2], [Status]) VALUES (10, N'mjones', N'Password321', N'mjones@mail.com', N'N', 10, N'Active              ')
GO
SET IDENTITY_INSERT [dbo].[usuarios] OFF
GO
ALTER TABLE [dbo].[usuarios] ADD  DEFAULT ('N') FOR [SessionActive]
GO
ALTER TABLE [dbo].[usuarios] ADD  DEFAULT ('Active') FOR [Status]
GO
ALTER TABLE [dbo].[rol_rolOpciones]  WITH CHECK ADD FOREIGN KEY([Rol_idRol])
REFERENCES [dbo].[Rol] ([idRol])
GO
ALTER TABLE [dbo].[rol_rolOpciones]  WITH CHECK ADD FOREIGN KEY([RolOpciones_idOpcion])
REFERENCES [dbo].[RolOpciones] ([idOpcion])
GO
ALTER TABLE [dbo].[rol_usuarios]  WITH CHECK ADD FOREIGN KEY([Rol_idRol])
REFERENCES [dbo].[Rol] ([idRol])
GO
ALTER TABLE [dbo].[rol_usuarios]  WITH CHECK ADD FOREIGN KEY([usuarios_idUsuario])
REFERENCES [dbo].[usuarios] ([idUsuario])
GO
ALTER TABLE [dbo].[Sessions]  WITH CHECK ADD FOREIGN KEY([usuarios_idUsuario])
REFERENCES [dbo].[usuarios] ([idUsuario])
GO
ALTER TABLE [dbo].[usuarios]  WITH CHECK ADD FOREIGN KEY([Persona_idPersona2])
REFERENCES [dbo].[Persona] ([idPersona])
GO
/****** Object:  StoredProcedure [dbo].[sp_AssignRolToUsuario]    Script Date: 15/10/2024 15:16:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_AssignRolToUsuario]
    @Rol_idRol INT,
    @usuarios_idUsuario INT
AS
BEGIN
    INSERT INTO rol_usuarios (Rol_idRol, usuarios_idUsuario)
    VALUES (@Rol_idRol, @usuarios_idUsuario);
END
GO
/****** Object:  StoredProcedure [dbo].[sp_DeleteUsuario]    Script Date: 15/10/2024 15:16:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_DeleteUsuario]
    @idUsuario INT
AS
BEGIN
    UPDATE usuarios
    SET Status = 'Deleted'
    WHERE idUsuario = @idUsuario;
END
GO
/****** Object:  StoredProcedure [dbo].[sp_GetUsuarios]    Script Date: 15/10/2024 15:16:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_GetUsuarios]
AS
BEGIN
    SELECT u.idUsuario, u.UserName, u.Mail, u.Status, p.Nombres, p.Apellidos, u.Password, u.SessionActive
    FROM usuarios u
    INNER JOIN Persona p ON u.Persona_idPersona2 = p.idPersona;
END

GO
/****** Object:  StoredProcedure [dbo].[sp_InsertRol]    Script Date: 15/10/2024 15:16:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_InsertRol]
    @RolName VARCHAR(50)
AS
BEGIN
    INSERT INTO Rol (RolName)
    VALUES (@RolName);
END
GO
/****** Object:  StoredProcedure [dbo].[sp_InsertSession]    Script Date: 15/10/2024 15:16:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_InsertSession]
    @FechaIngreso DATE,
    @usuarios_idUsuario INT
AS
BEGIN
    INSERT INTO Sessions (FechaIngreso, usuarios_idUsuario)
    VALUES (@FechaIngreso, @usuarios_idUsuario);
END
GO
/****** Object:  StoredProcedure [dbo].[sp_InsertUsuario]    Script Date: 15/10/2024 15:16:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_InsertUsuario]
    @Nombres VARCHAR(60),
    @Apellidos VARCHAR(60),
    @Identificacion VARCHAR(10),
    @FechaNacimiento DATE,
    @UserName VARCHAR(50),
    @Password VARCHAR(50),
    @Mail VARCHAR(120),
    @Status CHAR(20),
    @RolId INT
AS
BEGIN
    BEGIN TRY
        -- Inserta en la tabla Persona
        INSERT INTO Persona (Nombres, Apellidos, Identificacion, FechaNacimiento)
        VALUES (@Nombres, @Apellidos, @Identificacion, @FechaNacimiento);
        
        -- Obtén el idPersona recién insertado
        DECLARE @PersonaId INT = SCOPE_IDENTITY();

        -- Inserta en la tabla Usuarios
        INSERT INTO usuarios (UserName, Password, Mail, Persona_idPersona2, Status)
        VALUES (@UserName, @Password, @Mail, @PersonaId, @Status);

        -- Obtén el idUsuario recién insertado
        DECLARE @UsuarioId INT = SCOPE_IDENTITY();

        -- Inserta en la tabla rol_usuarios
        INSERT INTO rol_usuarios (Rol_idRol, usuarios_idUsuario)
        VALUES (@RolId, @UsuarioId);

    END TRY
    BEGIN CATCH
        -- Manejo de errores
        THROW;
    END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[sp_UpdatePersona]    Script Date: 15/10/2024 15:16:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_UpdatePersona]
    @idPersona INT,
    @Nombres VARCHAR(60),
    @Apellidos VARCHAR(60),
    @Identificacion VARCHAR(10),
    @FechaNacimiento DATE
AS
BEGIN
    UPDATE Persona
    SET 
        Nombres = @Nombres,
        Apellidos = @Apellidos,
        Identificacion = @Identificacion,
        FechaNacimiento = @FechaNacimiento
    WHERE idPersona = @idPersona;
END
GO
/****** Object:  StoredProcedure [dbo].[sp_UpdateUsuario]    Script Date: 15/10/2024 15:16:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_UpdateUsuario]
    @idUsuario INT,
    @UserName VARCHAR(50),
    @Password VARCHAR(50),
    @Mail VARCHAR(120),
    @Status CHAR(1),
    @RolId INT
AS
BEGIN
    UPDATE usuarios
    SET 
        UserName = @UserName,
        Password = @Password,
        Mail = @Mail,
        Status = @Status
    WHERE idUsuario = @idUsuario;

    -- Actualizar rol en la tabla rol_usuarios
    UPDATE rol_usuarios
    SET Rol_idRol = @RolId
    WHERE usuarios_idUsuario = @idUsuario;
END
GO
