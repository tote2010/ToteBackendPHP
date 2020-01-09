<?php

/**
 * Backend - KumbiaPHP Backend
 * PHP version 5
 * LICENSE
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU Affero General Public License as
 * published by the Free Software Foundation, either version 3 of the
 * License, or (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * ERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
 * GNU Affero General Public License for more details.
 *
 * You should have received a copy of the GNU Affero General Public License
 * along with this program. If not, see <http://www.gnu.org/licenses/>.
 *
 * @package Controller
 * @license http://www.gnu.org/licenses/agpl.txt GNU AFFERO GENERAL PUBLIC LICENSE version 3.
 * @author Manuel José Aguirre Garcia <programador.manuel@gmail.com>
 */
Load::models('usuarios');

class UsuariosController extends AdminController {

    /**
     * Luego de ejecutar las acciones, se verifica si la petición es ajax
     * para no mostrar ni vista ni template.
     */
    protected function after_filter() {
        if (Input::isAjax()) {
            View::select(NULL, NULL);
        }
    }

    public function index() {
        try {
            $dev = false;
            if(Load::model('usuarios')->rolIdUsuario(Auth::get('id')) == 4) $dev = true;
            
            $usr = new Usuarios();
            if($dev == true){
                $this->usuarios = $usr->find();
            } else {
                $this->usuarios = $usr->listarUsuariosSistema();
            }
            
        } catch (KumbiaException $e) {
            View::excepcion($e);
        }
    }

    /**
     * Cambio de los datos personales de usuario.
     * 
     */
    public function perfil() {
        try {
            $usr = new Usuarios();
            $this->usuario1 = $usr->find_first(Auth::get('id'));
            $this->usuario1->begin();
            if (Input::hasPost('usuario1')) {
                if ($usr->update(Input::post('usuario1'))) {
                    Flash::valid('Datos Actualizados Correctamente.');
                    $this->usuario1 = $usr;
                    $this->usuario1->commit();
                }
            } else if (Input::hasPost('usuario2')) {
                if ($usr->cambiarClave(Input::post('usuario2'))) {
                    Flash::valid('Clave Actualizada Correctamente.');
                    $this->usuario1 = $usr;
                    $this->usuario1->commit();
                } else {
                    $this->usuario1->rollback();
                    Flash::warning('Hubo un error al intentar Actualizar la Clave de Usuario.');
                }
            } else if(Input::hasPost('usuario3')){
                $ruta = dirname($_SERVER['SCRIPT_FILENAME']) . '/img/upload/usuarios/' ;
                $file = Upload::factory('img', 'image');
                $file->setPath($ruta);
                $file->overwrite(true);
                $file->setMaxSize('512 K');
                $file->setExtensions(array('jpg', 'jpeg', 'png'));
                $ext = basename($_FILES["img"]['type']);
                $imagen = Utils::slug($this->usuario1->id) . '.' . $ext;
                $this->usuario1->img = $imagen;

                if ($file->isUploaded()) {
                    if ($file->save($imagen) && $this->usuario1->save()) {
                        Flash::valid('Foto de Perfil actualizada exitosamente.');
                        $this->usuario1->commit();
                        return Router::redirect();
                    } else {
                        Flash::error('Hubo un error al intentar actualizar la Foto de Perfil.');
                        //$file->remove($ruta, $imagen);
                        $this->usuario1->rollback();
                    }
                }
            }
        } catch (KumbiaException $e) {
            View::excepcion($e);
        }
    }

    /**
     * Crea un usuario desde el backend.
     */
    public function crear() {
        try {
            $this->dev = false;
            if(Load::model('usuarios')->rolIdUsuario(Auth::get('id')) == 4) $this->dev = true;
            
            if (Input::hasPost('usuario')) {
                //esto es para tener atributos que no son campos de la tabla
                $usr = new Usuarios();
                //guarda los datos del usuario, y le asigna los roles 
                //seleccionados en el formulario.
                if ($usr->guardar(Input::post('usuario'), Input::post('roles_id'))) {
                    Flash::valid('El Usuario ha sido ingresado exitosamente.');
                    
                } else {
                    Flash::warning('No se Pudieron Guardar los Datos...!!!');
                }
            }
        } catch (KumbiaException $e) {
            View::excepcion($e);
        }
    }

    /**
     * Edita los datos de un usuario desde el backend.
     * @param  int $id id del usuario a editar
     */
    public function editar($id) {
        try {
            $this->dev = false;
            if(Load::model('usuarios')->rolIdUsuario(Auth::get('id')) == 4) $this->dev = true;
            
            $id = (int) $id;
            $usr = new Usuarios();
            $this->usuario = $usr->find_first($id);

            if ($this->usuario) {// verificamos la existencia del usuario
                //obtenemos los roles que tiene el usuario
                //para mostrar en el combo.
                $this->usuario->begin();
                $rol = Load::model('roles_usuarios')->find_by_usuarios_id($usr->id);
                $this->roles_id = $rol->roles_id;;

                if (Input::hasPost('usuario')) {
                    //guarda los datos del usuario, y le asigna los roles 
                    //seleccionados en el formulario.
                    if ($usr->actualizar(Input::post('usuario'))) {
                        Flash::valid('Los Datos del Usuario han sido actualizadoa exitosamente.');
                        if (!Input::isAjax()) {
                            $this->usuario->commit();
                            return Router::redirect();
                        }
                    } else {
                        $this->usuario->rollback();
                        Flash::warning('Hubo un error al intentar Actualizar los Datos.');
                    }
                } else if (Input::hasPost('usuario2')) {
                    if ($usr->cambiarClave(Input::post('usuario2'))) {
                        Flash::valid('Clave Actualizada Correctamente.');
                        $this->usuario = $usr;
                        $this->usuario->commit();
                    } else {
                        $this->usuario->rollback();
                        Flash::warning('Hubo un error al intentar Actualizar la Clave de Usuario.');
                    }
                } else if(Input::hasPost('usuario3')){
                    $ruta = dirname($_SERVER['SCRIPT_FILENAME']) . '/img/upload/usuarios/' ;
                    $file = Upload::factory('img', 'image');
                    $file->setPath($ruta);
                    $file->overwrite(true);
                    $file->setMaxSize('1024 K');
                    $file->setExtensions(array('jpg', 'jpeg', 'png'));
                    $ext = basename($_FILES["img"]['type']);
                    $imagen = Utils::slug($this->usuario->id) . '.' . $ext;
                    $this->usuario->img = $imagen;

                    if ($file->isUploaded()) {
                        if ($file->save($imagen) && $this->usuario->save()) {
                            Flash::valid('Foto de Perfil actualizada exitosamente.');
                            $this->usuario->commit();
                            return Router::redirect();
                        } else {
                            Flash::error('Hubo un error al intentar actualizar la Foto de Perfil.');
                            //$file->remove($ruta, $imagen);
                            $this->usuario->rollback();
                        }
                    }
                }
            } else {
                Flash::warning("No existe ningun usuario con id '{$id}'");
                if (!Input::isAjax()) {
                    return Router::redirect();
                }
            }
        } catch (KumbiaException $e) {
            View::excepcion($e);
        }
    }
	
	public function eliminar($id = NULL) {
        try {
            (int) $id;
            $usr = new Usuarios();
            $usr = $usr->find_first($id);
            if (!$usr) {
                Flash::warning("No existe ningun usuario con id '{$id}'");
            } elseif ($usr->delete()) {
                //Eliminamos el archivo si existe
                if($usr->img){
                    $archivo = Upload::factory('archivo', 'image');
                    $nombrearchivo = $usr->img;
                    $ruta = dirname(APP_PATH) . '/public/img/upload/usuarios/';
                    $archivo->remove($ruta, $nombrearchivo);
                }
                Flash::valid("El Usuario <b>{$usr->nombres} {$usr->apellido}</b> ha sido Eliminado.");
            } else {
                Flash::warning("No se Pudo Eliminar el Usuario <b>{$usr->nombres} {$usr->apellido}</b>.");
            }
        } catch (KumbiaException $e) {
            View::excepcion($e);
        }
        return Router::redirect();
    }

    /**
     * Activa un usuario desde el backend
     * @param  int $id id del usuario a activar
     */
    public function activar($id) {
        try {
            $id = (int) $id;
            $usuario = new Usuarios();
            if (!$usuario->find_first($id)) { //si no existe el usuario
                Flash::warning("No existe ningun usuario con id '{$id}'");
            } else if ($usuario->activar()) {
                Flash::valid("La Cuenta del Usuario {$usuario->login} ({$usuario->nombres}) fué activada...!!!");
            } else {
                Flash::warning('No se Pudo Activar la cuenta del Usuario...!!!');
            }
        } catch (KumbiaException $e) {
            View::excepcion($e);
        }
        return Router::toAction('');
    }

    /**
     * Desactiva un usuario desde el backend
     * @param  int $id id del usuario a desactivar
     */
    public function desactivar($id) {
        try {
            $id = (int) $id;
            $usuario = new Usuarios();
            if (!$usuario->find_first($id)) { //si no existe el usuario
                Flash::warning("No existe ningun usuario con id '{$id}'");
            } else if ($usuario->desactivar()) {
                Flash::valid("La Cuenta del Usuario {$usuario->login} ({$usuario->nombres}) fué desactivada...!!!");
            } else {
                Flash::warning('No se Pudo Desactivar la cuenta del Usuario...!!!');
            }
        } catch (KumbiaException $e) {
            View::excepcion($e);
        }
        return Router::toAction('');
    }

}
