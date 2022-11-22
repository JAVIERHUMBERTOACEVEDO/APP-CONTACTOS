///////////////////////////////////////
/// JAVIER HUMBERTO ACEVEDO GALLEGO///
/// javikaru@hotmail.com.c0        ///
//////////////////////////////////////
program APP_CONTACTOS;

uses
  Vcl.Forms,
  U_GESTION_CONTACTO in 'U_GESTION_CONTACTO.pas' {FRM_GESTION_CONTACTO},
  U_CONTACTO_DETALLE in 'U_CONTACTO_DETALLE.pas' {FRM_CONTACTO_DETALLE},
  U_MENU in 'U_MENU.pas' {FRM_MENU};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title := 'App Gestión Contactos';
  Application.CreateForm(TFRM_GESTION_CONTACTO, FRM_GESTION_CONTACTO);
  Application.CreateForm(TFRM_CONTACTO_DETALLE, FRM_CONTACTO_DETALLE);
  Application.CreateForm(TFRM_MENU, FRM_MENU);
  Application.Run;
end.
