///////////////////////////////////////
/// JAVIER HUMBERTO ACEVEDO GALLEGO///
/// javikaru@hotmail.com.c0        ///
//////////////////////////////////////
unit U_CONTACTO_DETALLE;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls,INIFILES,
  Vcl.Buttons,U_GESTION_CONTACTO;

type
  TFRM_CONTACTO_DETALLE = class(TForm)
    Panel1: TPanel;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    Label2: TLabel;
    Label1: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Edit5: TEdit;
    Label5: TLabel;
    Edit6: TEdit;
    Label6: TLabel;
    Label7: TLabel;
    Edit7: TEdit;
    BitBtn3: TBitBtn;
    procedure BitBtn1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);

  private
    { Private declarations }
  public


    /// <summary>
    /// VALIDA DIFERENTES ASPECTOS ANTES DE GUARDAR LA DATA
    /// </summary>
    /// <param name="matriz">
    /// Matriz de string con los datos de los contactos
    /// </param>
    /// <param name="cedula">
    /// cedula del contacto a crear
    /// </param>
    /// <returns>
    /// True si fue creado Exitosamente;
    /// de lo contrario False.
    /// </returns>
    function Validaciones(cedula,primer_nombre,primer_apellido,telefono:string;matriz:array of TFRM_GESTION_CONTACTO.tcontacto;modo:string ): boolean;

  end;

var
  FRM_CONTACTO_DETALLE: TFRM_CONTACTO_DETALLE;

implementation

{$R *.dfm}



{ TFRM_CONTACTO_DETALLE }

procedure TFRM_CONTACTO_DETALLE.BitBtn1Click(Sender: TObject);
begin
  FRM_GESTION_CONTACTO.Informacion_Contactos.AddPair('Primer_Nombre',trim(edit1.text));
  FRM_GESTION_CONTACTO.Informacion_Contactos.AddPair('Segundo_Nombre',trim(edit2.text));
  FRM_GESTION_CONTACTO.Informacion_Contactos.SaveToFile(FRM_GESTION_CONTACTO.Nombre_Archivo); //Guardamos el texto en el archivo.
  FRM_GESTION_CONTACTO.Informacion_Contactos.Free; //Borramos el objeto de la memoria
end;



procedure TFRM_CONTACTO_DETALLE.BitBtn3Click(Sender: TObject);
begin

   if FRM_CONTACTO_DETALLE.Caption='Crear Contacto' then
    begin
       if Validaciones(trim(Edit7.text),trim(Edit1.text),trim(Edit3.text),trim(Edit5.text),FRM_GESTION_CONTACTO.Datos_Contactos,'CREAR')=false then
       begin
         exit;
       end;
       FRM_GESTION_CONTACTO.Guardar_Datos_Local(trim(Edit7.text),trim(Edit1.text),trim(Edit2.text),trim(Edit3.text),trim(Edit4.text),trim(Edit5.text),trim(Edit6.text) );
    end;

   if FRM_CONTACTO_DETALLE.Caption='Editar Contacto' then
    begin
       if Validaciones(trim(Edit7.text),trim(Edit1.text),trim(Edit3.text),trim(Edit5.text),FRM_GESTION_CONTACTO.Datos_Contactos,'EDITAR')=false then
       begin
         exit;
       end;
       FRM_GESTION_CONTACTO.Editar_Datos_Local(trim(Edit7.text),trim(Edit1.text),trim(Edit2.text),trim(Edit3.text),trim(Edit4.text),trim(Edit5.text),trim(Edit6.text),FRM_GESTION_CONTACTO.id_seleccionado);
    end;

       FRM_GESTION_CONTACTO.Cargar_Data_Local();
       FRM_GESTION_CONTACTO.Mostrar_Data(FRM_GESTION_CONTACTO.Datos_Contactos);
       FRM_CONTACTO_DETALLE.Close;

end;

procedure TFRM_CONTACTO_DETALLE.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
action:=cafree;
end;

procedure TFRM_CONTACTO_DETALLE.FormShow(Sender: TObject);
begin

  Top := 150;
  Left := Round(Screen.Width / 2) - Round(Width / 2); // POSICIIONA VENTANA

        BitBtn3.Caption:=FRM_CONTACTO_DETALLE.Caption;


end;



function TFRM_CONTACTO_DETALLE.Validaciones(cedula,primer_nombre,primer_apellido,telefono:string;matriz:array of TFRM_GESTION_CONTACTO.tcontacto;modo:string ): boolean;
var
i,contador:integer;
begin
     //VERIFICA QUE EL CONTACTO NO SE HAYA CREADO PREVIEMNTE

    if modo='CREAR' then
    begin
     FOR i:=0 to length(matriz)-1 DO
     begin
       if cedula=matriz[i].cedula then
       begin
         Application.MessageBox(pchar('Ya existe el contacto '+cedula),
         pchar('Contacto.'), (MB_OK + MB_ICONEXCLAMATION));
         result:=false;
         edit7.SetFocus;
         exit;
       end;
     end;
    end;

    if modo='EDITAR' then
    begin

     contador:=0;
     FOR i:=0 to length(matriz)-1 DO
     begin
       if (cedula=matriz[i].cedula) and (i<>FRM_GESTION_CONTACTO.id_seleccionado)  then
       begin
         Application.MessageBox(pchar('Ya existe otro contacto con la misma cedula '+cedula),
         pchar('Contacto Duplicidad.'), (MB_OK + MB_ICONEXCLAMATION));
         result:=false;
         edit7.SetFocus;
         exit;
       end;
     end;
    end;


     if (length(cedula)<8) then
     begin
         Application.MessageBox(pchar('Cedula debe tener minimo 8 caracteres'),
         pchar('Cedula.'), (MB_OK + MB_ICONEXCLAMATION));
         result:=false;
         edit7.SetFocus;
         exit;
     end;


     if primer_nombre=emptystr then
     begin
         Application.MessageBox(pchar('Primer Nombre es obligatorio'),
         pchar('Primer Nombre.'), (MB_OK + MB_ICONEXCLAMATION));
         result:=false;
         edit1.SetFocus;
         exit;
     end;

     if primer_apellido=emptystr then
     begin
         Application.MessageBox(pchar('Primer Apellido es obligatorio'),
         pchar('Primer Apellido.'), (MB_OK + MB_ICONEXCLAMATION));
         result:=false;
         edit3.SetFocus;
         exit;
     end;

     if length(telefono)<5 then
     begin
         Application.MessageBox(pchar('Teléfono debe tener minimo 5 caracteres'),
         pchar('Teléfono.'), (MB_OK + MB_ICONEXCLAMATION));
         result:=false;
         edit5.SetFocus;
         exit;
     end;

     result:=true;
end;



END.
