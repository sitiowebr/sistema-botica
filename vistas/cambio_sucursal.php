<?php
    // Activar el almacenamiento en el buffer
    ob_start();
    session_start();

    if (!isset($_SESSION["nombre"])) {
        header("Location:index.php");
    } else {
        require 'header.php';

        if ($_SESSION['sucursales'] == 1) {
?>

<!-- Contenido -->
<div class="content-wrapper" >
    <!-- Main content -->
    <section class="content">
        <div class="row">
            <div class="col-md-12">
                <div class="box">
                    <div class="box-header with-border">
                        <h1 class="box-title">Cambio de Sucursal</h1>
                    </div>
                    <!-- /.box-header -->
                    <!-- Centro -->
                    <div class="panel-body" id="formularioregistros">
                        <!-- Formulario -->
                        <form name="formulario" method="POST" id="formulario">
                            <div class="form-group col-lg-6 col-md-6 col-sm-6 col-xs-12">
                                <label>Sucursal Actual:</label>
                                <input type="text" class="form-control" name="sucursal_actual" id="sucursal_actual" value="<?php echo $_SESSION['']; ?>" disabled>
                            </div>
                            <div class="form-group col-lg-6 col-md-6 col-sm-6 col-xs-12">
                                <label>Nueva Sucursal:</label>
                                <select id="id_sucursal" name="id_sucursal" class="form-control selectpicker" data-live-search="true" required></select>
                          </div>
                                    <!-- Aquí puedes cargar dinámicamente las opciones de sucursales desde la base de datos -->
                                </select>
                            </div>
                            <div class="form-group col-lg-12 col-md-12 col-sm-12 col-xs-12">
                                <button class="btn btn-primary" type="submit" id="btnGuardar">
                                    <i class="fa fa-save"></i>&nbsp;&nbsp;Guardar Cambios
                                </button>
                                <button class="btn btn-danger" onclick="cancelarform()" type="button">
                                    <i class="fa fa-arrow-circle-left"></i>&nbsp;Cancelar
                                </button>
                            </div>
                        </form>
                        <!-- Fin Formulario -->
                    </div>
                    <!-- Fin Centro -->
                </div><!-- /.box -->
            </div><!-- /.col -->
        </div><!-- /.row -->
    </section><!-- /.content -->
</div><!-- /.content-wrapper -->
<!-- Fin Contenido -->

<?php
        }
    }

    require 'footer.php';
?>

<script type="text/javascript" src="scripts/cambio_sucursal.js"></script>

<?php
    ob_end_flush();
?>
