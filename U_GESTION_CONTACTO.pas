///////////////////////////////////////
/// JAVIER HUMBERTO ACEVEDO GALLEGO///
/// javikaru@hotmail.com.c0        ///
//////////////////////////////////////
unit U_GESTION_CONTACTO;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.StdCtrls, Vcl.Buttons,INIFILES,
  Vcl.ExtCtrls, Vcl.Grids, Vcl.Menus, Vcl.Imaging.pngimage;

type
  TFRM_GESTION_CONTACTO = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    ListView1: TListView;
    BitBtn1: TBitBtn;
    Label1: TLabel;
    BalloonHint1: TBalloonHint;
    Image1: TImage;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure ListView1DblClick(Sender: TObject);
    procedure Image1MouseEnter(Sender: TObject);
    procedure Image1MouseLeave(Sender: TObject);



    type
    TContacto=RECORD
    cedula:string;
    primer_nombre:string;
    segundo_nombre:string;
    primer_apellido:string;
    segundo_apellido:string;
    telefono:string;
    telefono2:string;
    end;

    var


    procedure BitBtn1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);

  private
    { Private declarations }
  public

   { Public declarations }


    /// <summary>
    /// CREA ARCHIVO DE TEXTO SI NO EXISTE
    /// </summary>
    procedure Crear_Archivo_Datos;

    /// <summary>
    /// MUESTRA DATOS DE CONTACTO EN LISTVIEW
    /// </summary>
    /// <param name="matriz">
    /// Matriz de string con los datos de los contactos
    /// </param>
    /// <returns>
    /// True si fue creado Exitosamente;
    /// de lo contrario False.
    /// </returns>
    function Mostrar_Data(matriz:array of tcontacto):boolean;

    /// <summary>
    /// CARGA DATA DE MANERA LOCAL Y LA MUESTRA EN COMPONENTE LISTVIEW
    /// </summary>
    function Cargar_Data_Local(): boolean;

    /// <summary>
    /// GUARDA LOS DATOS DE UN NUEVO CONTACTO LOCALMENTE
    /// </summary>
    /// <param name="cedula">
    /// cedula
    /// </summary>
    /// <param name="primer_nombre>
    /// primer_nombre
    /// </summary>
    /// <param name="segundo_nombre">
    /// segundo_nombre
    /// </summary>
    /// <param name="primer_apellido">
    /// primer_apellido
    /// </summary>
    /// <param name="segundo_apellido">
    /// segundo_apellido
    /// </summary>
    /// <param name="telefono">
    /// telefono
    /// </param>
    /// <param name="telefono2">
    /// telefono2
    /// </param>
    /// <returns>
    /// True si fue creado Exitosamente;
    /// de lo contrario False.
    /// </returns>
    function Guardar_Datos_Local(cedula,primer_nombre,segundo_nombre,primer_apellido,segundo_apellido,telefono,telefono2:string):boolean;

    /// <summary>
    /// EDITA LOS DATOS DE UN  CONTACTO LOCALMENTE
    /// </summary>
    /// <param name="cedula">
    /// cedula
    /// </summary>
    /// <param name="primer_nombre>
    /// primer_nombre
    /// </summary>
    /// <param name="segundo_nombre">
    /// segundo_nombre
    /// </summary>
    /// <param name="primer_apellido">
    /// primer_apellido
    /// </summary>
    /// <param name="segundo_apellido">
    /// segundo_apellido
    /// </summary>
    /// <param name="telefono">
    /// telefono
    /// </param>
    /// <param name="telefono2">
    /// telefono2
    /// </param>
    /// <returns>
    /// True si fue creado Exitosamente;
    /// de lo contrario False.
    /// </returns>
    function Editar_Datos_Local(cedula,primer_nombre,segundo_nombre,primer_apellido,segundo_apellido,telefono,telefono2:string;indice:integer ):boolean;

    /// <summary>
    /// ELIMINA DATA  LOCAL
    /// </summary>
    /// <param name="cedula">
    /// cedula
    /// </param>
    /// <param name="indice">
    /// indice de la fila a eliminar
    /// </param>
    /// <returns>
    /// True si fue creado Exitosamente;
    /// de lo contrario False.
    /// </returns>
    function Eliminar_Datos_Local(indice:integer):boolean;

    /// <summary>
    /// GUARDA DATA DESDE OBJETO LOCAL A ARCHIVO DE TEXTO
    /// </summary>
    /// <param name="matriz">
    /// Matriz de string con los datos de los contactos
    /// </param>
    /// <returns>
    /// True si fue creado Exitosamente;
    /// de lo contrario False.
    /// </returns>
    function Guarda_Archivo_Datos(matriz:array of tcontacto):boolean;

    /// <summary>
    /// EDITA DATA DESDE OBJETO LOCAL A ARCHIVO DE TEXTO
    /// </summary>
    /// <param name="matriz">
    /// Matriz de string con los datos de los contactos
    /// </param>
    /// <returns>
    /// True si fue creado Exitosamente;
    /// de lo contrario False.
    /// </returns>
    function Editar_Archivo_Datos(  matriz: array of tcontacto): boolean;




    VAR
    informacion_contactos:tstringlist;
    nombre_archivo:string;
    datos_contactos:array of tcontacto;
    archivo_datos:textfile;
    id_seleccionado:integer;
    contacto_seleccionado:tcontacto;

  end;

var
  FRM_GESTION_CONTACTO: TFRM_GESTION_CONTACTO;

implementation

{$R *.dfm}

uses U_CONTACTO_DETALLE, U_MENU;

procedure TFRM_GESTION_CONTACTO.BitBtn1Click(Sender: TObject);
begin

     Application.CreateForm(TFRM_CONTACTO_DETALLE,FRM_CONTACTO_DETALLE);
     FRM_CONTACTO_DETALLE.Caption:='Crear Contacto';
     FRM_CONTACTO_DETALLE.ShowModal;


end;



procedure TFRM_GESTION_CONTACTO.FormActivate(Sender: TObject);
begin
       Mostrar_Data(Datos_Contactos);
end;

procedure TFRM_GESTION_CONTACTO.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
action:=cafree;
end;

procedure TFRM_GESTION_CONTACTO.FormCreate(Sender: TObject);
begin

      Crear_Archivo_Datos();

end;


procedure TFRM_GESTION_CONTACTO.FormShow(Sender: TObject);
begin
  Top := 50;
  Left := Round(Screen.Width / 2) - Round(Width / 2); // POSICIIONA VENTANA
end;



function TFRM_GESTION_CONTACTO.Cargar_Data_Local(): boolean;
var
numero_filas,i,j,contador:integer;
linea,dato:string;
begin
        Informacion_Contactos.LoadFromFile(Nombre_Archivo);
        numero_filas:=Informacion_Contactos.count;
        SetLength(Datos_Contactos,numero_filas);


   try
        for I := 0 to Informacion_Contactos.count-1 do
        begin
           contador:=0;
           dato:=emptystr;
           linea:=Informacion_Contactos[i]; //EXTRAE DATOS DE TODA LA LINEA

          for J := 1 to length(linea)+1 do   //EXTRAE DATOS Y LOS PARSEA DE ACUERDO A LOS SEPARADORES
          begin
             if (linea[j]<>#0)and(linea[j]<>#9)and(linea[j]<>#10)and(linea[j]<>#13)  then  //SI CARACTER ES DIFERENTE DE TABULADOR,SALTO DE LINEA,RETORNO DE CARRO
             begin
             if j=31 then
             begin
               dato:=dato;
             end;
               dato:=dato+linea[j];

             end
             else
             begin

                case  contador of
                0: Datos_Contactos[i].cedula:=trim(dato);
                1: Datos_Contactos[i].primer_nombre:=trim(dato);
                2: Datos_Contactos[i].segundo_nombre:=trim(dato);
                3: Datos_Contactos[i].primer_apellido:=trim(dato);
                4: Datos_Contactos[i].segundo_apellido:=trim(dato);
                5: Datos_Contactos[i].telefono:=trim(dato);
                6: Datos_Contactos[i].telefono2:=trim(dato);
                end;

                 dato:=emptystr;
                contador:=contador+1;
             end;

          end;

       end;

  except

    Application.MessageBox(pchar('No se puedeo el archivo de manera local'),
    pchar('Error.'), (MB_OK + MB_ICONWARNING));
  end;


end;

procedure TFRM_GESTION_CONTACTO.Crear_Archivo_Datos;
var
i,j,contador,numero_filas:integer;

linea,dato:string;
begin

   Nombre_Archivo:='Datos_Contacto.txt';
   Informacion_Contactos:=TStringList.Create; //Creamos el objeto de tipo lista;

   //setlength(datos_linea)

 //EVALUA SI EL ARCHIVO DE CONTACTOS EXISTE
  try
    if FileExists(Nombre_Archivo)=false then //SI EL ARCHIVO NO EXISTE SE CREA
     begin
        try
           AssignFile(Archivo_Datos,Nombre_Archivo);
           Rewrite(Archivo_Datos);
           Write(Archivo_Datos,'');
        finally
            CloseFile(Archivo_Datos);
        end;
     end
     else
     begin //SI YA EXISTE EL ARCHIVO CARGAR LA INFORMACION EN UN OBJETO PARA SER MODIFICADA
      Cargar_Data_Local()
     end;
  except

    Application.MessageBox(pchar('No se puedeo crear el archivo Datos_Contacto.txt'),
    pchar('Error.'), (MB_OK + MB_ICONWARNING));
  end;


end;

function TFRM_GESTION_CONTACTO.Mostrar_Data(matriz:array of tcontacto):boolean;
var
i,numero_filas:integer;

begin
    numero_filas:=length(matriz);
    ListView1.Clear;

    try
        for I := 0 to numero_filas-1 do
        begin
               with ListView1.Items.add do
               begin
                SubItems.add(matriz[i].cedula);
                SubItems.add(matriz[i].primer_nombre);
                SubItems.add(matriz[i].segundo_nombre);
                SubItems.add(matriz[i].primer_apellido);
                SubItems.add(matriz[i].segundo_apellido);
                SubItems.add(matriz[i].telefono);
                SubItems.add(matriz[i].telefono2);
               end;

       end;

       result:=true;
    except
       Application.MessageBox(pchar('No se puede mostrar la data'),
       pchar('Error.'), (MB_OK + MB_ICONWARNING));
       result:=false;
    end;

end;


function TFRM_GESTION_CONTACTO.Guarda_Archivo_Datos( matriz: array of tcontacto): boolean;
  var
  i,lineas:integer;

begin

 TRY
   lineas:=length(matriz);
   Informacion_Contactos.Clear;

     for I := 0 to lineas-1 do
     begin
         Informacion_Contactos.Add(
             matriz[i].cedula+#9+matriz[i].primer_nombre+#9+matriz[i].segundo_nombre+#9+matriz[i].primer_apellido+#9+matriz[i].segundo_apellido+#9+matriz[i].telefono+#9+matriz[i].telefono2
             );
     end;

     Informacion_Contactos.SaveToFile(Nombre_Archivo);
     result:=true;

 EXCEPT
       Application.MessageBox(pchar('No se pudo guardar la data en el archivo e texto'),
       pchar('Error.'), (MB_OK + MB_ICONWARNING));
       result:=false;
 END;

end;

procedure TFRM_GESTION_CONTACTO.Image1MouseEnter(Sender: TObject);
begin
   BalloonHint1.Description := 'Aplicacíón Para La Gestión de Contactos'+#10+#13+
                               '-Para eliminar o editar un contacto, haz doble click sobre el mismo.'+#10+#13+#10+#13+
                               'Desarrollado por: '+#10+#13+
                               'Javier Humberto Acevedo Gallego - Javikaru@hotmail.com';
   BalloonHint1.Style := bhsBalloon;
   BalloonHint1.Delay:=50;
   BalloonHint1.ShowHint(Image1);
end;

procedure TFRM_GESTION_CONTACTO.Image1MouseLeave(Sender: TObject);
begin
   if BalloonHint1.ShowingHint=true then
      begin
       BalloonHint1.HideHint;
      end;
end;

function TFRM_GESTION_CONTACTO.Editar_Archivo_Datos(  matriz: array of tcontacto): boolean;
  var
  i,lineas:integer;

begin

 TRY
   lineas:=length(matriz);
   Informacion_Contactos.Clear;

     for I := 0 to lineas-1 do
     begin
         Informacion_Contactos.Add(
             matriz[i].cedula+#9+matriz[i].primer_nombre+#9+matriz[i].segundo_nombre+#9+matriz[i].primer_apellido+#9+matriz[i].segundo_apellido+#9+matriz[i].telefono+#9+matriz[i].telefono2
             );
     end;

     Informacion_Contactos.SaveToFile(Nombre_Archivo);
     result:=true;

 EXCEPT
       Application.MessageBox(pchar('No se pudo guardar la data en el archivo e texto'),
       pchar('Error.'), (MB_OK + MB_ICONWARNING));
       result:=false;
 END;

end;




procedure TFRM_GESTION_CONTACTO.ListView1DblClick(Sender: TObject);
begin

 if ListView1.Items.Count=0 then
 begin
   Application.MessageBox(pchar('No hay contactos para editar o eliminar.' ),
   pchar('No hay contactos.'), (MB_OK + MB_ICONWARNING));
   exit;
 end;

 id_seleccionado:=ListView1.Selected.Index;

 //CARGO DATA DE CONTACTO SELECCIONADO
 contacto_seleccionado.cedula:=ListView1.Items[id_seleccionado].SubItems[0];
 contacto_seleccionado.primer_nombre:=ListView1.Items[id_seleccionado].SubItems[1];
 contacto_seleccionado.segundo_nombre:=ListView1.Items[id_seleccionado].SubItems[2];
 contacto_seleccionado.primer_apellido:=ListView1.Items[id_seleccionado].SubItems[3];
 contacto_seleccionado.segundo_apellido:=ListView1.Items[id_seleccionado].SubItems[4];
 contacto_seleccionado.telefono:=ListView1.Items[id_seleccionado].SubItems[5];
 contacto_seleccionado.telefono2:=ListView1.Items[id_seleccionado].SubItems[6];

 Application.CreateForm(TFRM_MENU,FRM_MENU);
 FRM_MENU.Caption:=contacto_seleccionado.cedula+' '+contacto_seleccionado.primer_nombre+' '+contacto_seleccionado.primer_apellido;
 FRM_MENU.ShowModal;

end;

function TFRM_GESTION_CONTACTO.Guardar_Datos_Local(cedula,primer_nombre,segundo_nombre,primer_apellido,segundo_apellido,telefono,telefono2:string ):boolean;
var
i,longitud:integer;
begin

    try
      longitud:=length(datos_contactos );
      SetLength(datos_contactos,longitud+1);

      datos_contactos[longitud].cedula:=cedula;
      datos_contactos[longitud].primer_nombre:=primer_nombre;
      datos_contactos[longitud].segundo_nombre:=segundo_nombre;
      datos_contactos[longitud].primer_apellido:=primer_apellido;
      datos_contactos[longitud].segundo_apellido:=segundo_apellido;
      datos_contactos[longitud].telefono:=telefono;
      datos_contactos[longitud].telefono2:=telefono2;

      //GUARDA DE OBJETO A ARCHIVO DE TEXTO EN DISCO
      Guarda_Archivo_Datos(datos_contactos);

       Application.MessageBox(pchar('Contacto  '+cedula+' registrado con éxito.' ),
       pchar('Contacto Registrado.'), (MB_OK + MB_ICONINFORMATION));
       result:=true;
    except
       Application.MessageBox(pchar('No se pudo registrar el contacto' ),
       pchar('Error.'), (MB_OK + MB_ICONwarning));
       result:=false;
    end;

end;

function TFRM_GESTION_CONTACTO.Editar_Datos_Local(cedula,primer_nombre,segundo_nombre,primer_apellido,segundo_apellido,telefono,telefono2:string;indice:integer ):boolean;
begin

    TRY
      datos_contactos[id_seleccionado].cedula:=cedula;
      datos_contactos[id_seleccionado].primer_nombre:=primer_nombre;
      datos_contactos[id_seleccionado].segundo_nombre:=segundo_nombre;
      datos_contactos[id_seleccionado].primer_apellido:=primer_apellido;
      datos_contactos[id_seleccionado].segundo_apellido:=segundo_apellido;
      datos_contactos[id_seleccionado].telefono:=telefono;
      datos_contactos[id_seleccionado].telefono2:=telefono2;

      //GUARDA DE OBJETO A ARCHIVO DE TEXTO EN DISCO
      Guarda_Archivo_Datos(datos_contactos);

       Application.MessageBox(pchar('Contacto  '+cedula+' editado con éxito.' ),
       pchar('Contacto Editado.'), (MB_OK + MB_ICONINFORMATION));
       result:=true;

    except
       Application.MessageBox(pchar('No se pudo reditar el contacto' ),
       pchar('Error.'), (MB_OK + MB_ICONwarning));
       result:=false;
    end;

end;



function TFRM_GESTION_CONTACTO.Eliminar_Datos_Local(indice:integer): boolean;
begin

   if   Application.MessageBox(pchar('Realmente desea aliminar el contacto '+informacion_contactos[indice]),
       pchar('Eliminar Contacto.'), (MB_YESNO + MB_ICONINFORMATION))=6 then
    begin
          TRY
           informacion_contactos.delete(indice);
           Informacion_Contactos.SaveToFile(Nombre_Archivo);
           Cargar_Data_Local();
           Mostrar_Data(datos_contactos);
           result:=true;
          except
             Application.MessageBox(pchar('No se pudo eliminar el contacto' ),
             pchar('Error.'), (MB_OK + MB_ICONwarning));
             result:=false;
          end;
    end;


end;

END.
