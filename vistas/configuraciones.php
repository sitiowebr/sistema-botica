<?php 
ob_start();
session_start();
  if (!isset($_SESSION['nombre'])) {
    header("Location:index.php");
  }else{
    require 'header.php';
  if($_SESSION['configuraciones']==1){
    require "../modelos/Configuraciones.php";
  $configuracion = new Configuraciones();
  $rspta = $configuracion->mostrar();
  $reg = $rspta->fetch_object();
 
?>
<!-- <link rel="stylesheet" type="text/css" href="style/loading.css"> -->

	<div class="content-wrapper">
    <!-- Content Header (Page header) -->
	    <section class="content-header">
	      <h1>
	        CONFIGURACIONES
	        <small><?php echo $reg->nombre_comercial; ?></small>
	      </h1>
	      <ol class="breadcrumb">
	       <!--  <li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>
	        <li><a href="#">Layout</a></li>
	        <li class="active">Fixed</li> -->
	      </ol>
	    </section>

  

         <!-- Main content -->
         <section class="content">
             <div class="row">
               <div class="col-md-12">
                   <div class="box box-primary">
                     <div class="box-header with-border">
                           <h1 class="box-title"> </h1>
                         <div class="box-tools pull-right">
                         </div>
                     </div>
                     <!-- /.box-header -->
                     <!-- centro -->
                     <div class="panel-body table-responsive"  id="listadoregistros">
                      <form class="form-horizontal"  id="formulario" name="formulario" enctype="multipart/form-data">
                        <div class="col-lg-3 col-md-3 col-sm-3 col-xs-12">
                          <div class="load_img">
                            <input type="hidden" name="imagenactual" id="imagenactual" value="<?php echo $reg->logo; ?>">
                            <img src="../files/perfil/<?php echo $reg->logo; ?>" class="img-responsive"  id="previsualizar" style="width: 400px; ">
                          </div>
                          <br>
                          <div class="form-group">
                            <input type="file" name="imagen" id="imagen" class="" onchange="">
                          </div>
                        </div>
                            <!-- <form class="form-horizontal" id="formulario" name="formulario"> -->
                        <div class="col-lg-9 col-md-9 col-sm-9 col-xs-12">
                              <div class="form-group">
                                <label class="control-label col-lg-3 col-md-3 col-sm-3 col-xs-12">Razón Social :</label>
                                <div class="col-lg-5 col-md-5 col-sm-5 col-xs-12">
                                  <input type="hidden" name="idperfil" id="idperfil"  value="<?php echo $reg->idperfil; ?>" class="form-control input-sm">
                                  <input type="text" name="razon_social" id="razon_social" value="<?php echo $reg->razon_social; ?>" class="form-control input-sm">
                                </div>
                              </div>
                              <div class="form-group">
                                <label class="control-label col-lg-3 col-md-3 col-sm-3 col-xs-12">Nombre Comercial :</label>
                                <div class="col-lg-5 col-md-5 col-sm-5 col-xs-12">
                                  <input type="text" name="nombre_comercial" id="nombre_comercial" value="<?php echo $reg->nombre_comercial; ?>" class="form-control input-sm">
                                </div>
                              </div>
                              <div class="form-group">
                                <label class="control-label col-lg-3 col-md-3 col-sm-3 col-xs-12">Ruc :</label>
                                <div class="col-lg-5 col-md-5 col-sm-5 col-xs-12">
                                  <input type="text" name="ruc" id="ruc" class="form-control input-sm" value="<?php echo $reg->ruc; ?>">
                                </div>
                              </div>
                              <div class="form-group">
                                <label class="control-label col-lg-3 col-md-3 col-sm-3 col-xs-12">Dirección :</label>
                                <div class="col-lg-5 col-md-5 col-sm-5 col-xs-12">
                                  <input type="text" name="direccion" id="direccion" class="form-control input-sm" value="<?php echo $reg->direccion; ?>">
                                </div>
                              </div>
                              <div class="form-group">
                                <label class="control-label col-lg-3 col-md-3 col-sm-3 col-xs-12">Distrito :</label>
                                <div class="col-lg-5 col-md-5 col-sm-5 col-xs-12">
                                  <input type="text" name="distrito" id="distrito" class="form-control input-sm" value="<?php echo $reg->distrito; ?>">
                                </div>
                              </div>
                              <div class="form-group">
                                <label class="control-label col-lg-3 col-md-3 col-sm-3 col-xs-12">Provincia :</label>
                                <div class="col-lg-5 col-md-5 col-sm-5 col-xs-12">
                                  <input type="text" name="provincia" id="provincia" class="form-control input-sm" value="<?php echo $reg->provincia; ?>">
                                </div>
                              </div>
                              <div class="form-group">
                                <label class="control-label col-lg-3 col-md-3 col-sm-3 col-xs-12">Departamento :</label>
                                <div class="col-lg-5 col-md-5 col-sm-5 col-xs-12">
                                  <input type="text" name="departamento" id="departamento" class="form-control input-sm" value="<?php echo $reg->departamento; ?>">
                                </div>
                              </div>
                              <div class="form-group">
                                <label class="control-label col-lg-3 col-md-3 col-sm-3 col-xs-12">Código postal:</label>
                                <div class="col-lg-5 col-md-5 col-sm-5 col-xs-12">
                                  <input type="text" name="codigo_postal" id="codigo_postal" class="form-control input-sm" value="<?php echo $reg->codigo_postal; ?>">
                                </div>
                              </div>
                              <div class="form-group">
                                <label class="control-label col-lg-3 col-md-3 col-sm-3 col-xs-12">Teléfono :</label>
                                <div class="col-lg-5 col-md-5 col-sm-5 col-xs-12">
                                  <input type="text" name="telefono" id="telefono" class="form-control input-sm" value="<?php echo $reg->telefono; ?>">
                                </div>
                              </div>
                              
                              <div class="form-group">
                                <label class="control-label col-lg-3 col-md-3 col-sm-3 col-xs-12">Correo electrónico :</label>
                                <div class="col-lg-5 col-md-5 col-sm-5 col-xs-12">
                                  <input type="text" name="email" id="email" class="form-control input-sm" value="<?php echo $reg->email; ?>">
                                </div>
                              </div>
                              <div class="form-group">
                                <label class="control-label col-lg-3 col-md-3 col-sm-3 col-xs-12">Pais :</label>
                                <div class="col-lg-5 col-md-5 col-sm-5 col-xs-12">
                                  <input type="text" name="pais" id="pais" class="form-control input-sm" value="<?php echo $reg->pais; ?>">
                                </div>
                              </div>
                              <div class="form-group">
                                <label class="control-label col-lg-3 col-md-3 col-sm-3 col-xs-12">sitio_web:</label>
                                <div class="col-lg-5 col-md-5 col-sm-5 col-xs-12">
                                  <input type="text" name="sitio_web" id="sitio_web" class="form-control input-sm" value="<?php echo $reg->sitio_web; ?>">
                                </div>
                              </div>
                              <div class="form-group">
                                <label class="control-label col-lg-3 col-md-3 col-sm-3 col-xs-12">direccion2:</label>
                                <div class="col-lg-5 col-md-5 col-sm-5 col-xs-12">
                                  <input type="text" name="direccion2" id="direccion2" class="form-control input-sm" value="<?php echo $reg->direccion2; ?>">
                                </div>
                              </div>
                              <div class="form-group">
                                <label class="control-label col-lg-3 col-md-3 col-sm-3 col-xs-12">fecha_autorizacion :</label>
                                <div class="col-lg-5 col-md-5 col-sm-5 col-xs-12">
                                  <input type="date" name="fecha_autorizacion" id="fecha_autorizacion" class="form-control input-sm" value="<?php echo $reg->fecha_autorizacion; ?>">
                                </div>
                              </div>
                              <div class="form-group">
                                <label class="control-label col-lg-3 col-md-3 col-sm-3 col-xs-12">publicidad :</label>
                                <div class="col-lg-5 col-md-5 col-sm-5 col-xs-12">
                                  <input type="text" name="publicidad" id="publicidad" class="form-control input-sm" value="<?php echo $reg->publicidad; ?>">
                                </div>
                              </div>
                             
                             
                             
                             

                                
                            <!-- </form> -->

                            <div class='col-md-12' id="result"></div><!-- Carga los datos ajax -->

                         
                        
                        </div>
                          <div class="panel-footer text-center col-lg-12 col-md-12 col-sm-12 col-xs-12">
                                <button type="submit" class="btn btn-sm btn-success" id="btnconfig"><i class="glyphicon glyphicon-refresh"></i> Actualizar datos</button>
                          </div>
                      </form>
                        
                     </div>
        
                      

                     <!--Fin centro -->
                   </div><!-- /.box -->
               </div><!-- /.col -->
           </div><!-- /.row -->
       </section><!-- /.content -->

     </div>

	

<?php
}else{
  require "noacceso.php";
}
	require_once('footer.php');

 ?>
 <script type="text/javascript" src="scripts/configuraciones.js"></script>
<?php 
  }
  ob_end_flush();
 ?>
