///////////////////////////////////////
/// JAVIER HUMBERTO ACEVEDO GALLEGO///
/// javikaru@hotmail.com.c0        ///
//////////////////////////////////////
unit U_MENU;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Buttons;

type
  TFRM_MENU = class(TForm)
    Panel1: TPanel;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    procedure FormShow(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BitBtn3Click(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FRM_MENU: TFRM_MENU;

implementation

{$R *.dfm}

uses U_CONTACTO_DETALLE, U_GESTION_CONTACTO;

procedure TFRM_MENU.BitBtn2Click(Sender: TObject);
begin
     Application.CreateForm(TFRM_CONTACTO_DETALLE,FRM_CONTACTO_DETALLE);
     FRM_CONTACTO_DETALLE.Caption:='Editar Contacto';
     FRM_CONTACTO_DETALLE.edit7.Text:=FRM_GESTION_CONTACTO.CONTACTO_SELECCIONADO.cedula;
     FRM_CONTACTO_DETALLE.edit1.Text:=FRM_GESTION_CONTACTO.CONTACTO_SELECCIONADO.primer_nombre;
     FRM_CONTACTO_DETALLE.edit2.Text:=FRM_GESTION_CONTACTO.CONTACTO_SELECCIONADO.segundo_nombre;
     FRM_CONTACTO_DETALLE.edit3.Text:=FRM_GESTION_CONTACTO.CONTACTO_SELECCIONADO.primer_apellido;
     FRM_CONTACTO_DETALLE.edit4.Text:=FRM_GESTION_CONTACTO.CONTACTO_SELECCIONADO.segundo_apellido;
     FRM_CONTACTO_DETALLE.edit5.Text:=FRM_GESTION_CONTACTO.CONTACTO_SELECCIONADO.telefono;
     FRM_CONTACTO_DETALLE.edit6.Text:=FRM_GESTION_CONTACTO.CONTACTO_SELECCIONADO.telefono2;

     FRM_MENU.HIDE;
     FRM_CONTACTO_DETALLE.ShowModal;
     FRM_MENU.CLOSE;
end;

procedure TFRM_MENU.BitBtn3Click(Sender: TObject);
begin

   FRM_MENU.HIDE;
   FRM_GESTION_CONTACTO.Eliminar_Datos_Local(FRM_GESTION_CONTACTO.id_seleccionado);
   FRM_MENU.CLOSE;

end;

procedure TFRM_MENU.FormClose(Sender: TObject; var Action: TCloseAction);
begin
ACTION:=CAFREE;
end;

procedure TFRM_MENU.FormShow(Sender: TObject);
begin
  Top := 220;
  Left := Round(Screen.Width / 2) - Round(Width / 2); // POSICIIONA VENTANA

end;

end.
