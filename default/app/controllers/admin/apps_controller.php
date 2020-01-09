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
 * @license NULL //http://www.gnu.org/licenses/agpl.txt GNU AFFERO GENERAL PUBLIC LICENSE version 3.
 * @author TOTE || Gastón Diego Mascialino <gaston@itgapps.com>
*/

Load::model('apps');

class AppsController extends AdminController {

    //public $template = 'backend';

    public function index() {        
        $apps = new Apps();
        $this->apps = $apps->find();                
    }

    //Add App
    public function add(){
        $this->title = 'Add a New App';
        $this->logo = null;
        
        try{
            if(Input::post('app')){
                $app = new Apps(Input::post('app'));
                $app->begin();
                
                // Tratamiento de archivos de imagenes
                $file = Upload::factory('logo', 'image');
                $baseName = basename($_FILES["logo"]['name']);
                $explode = explode(".", $baseName);
                $reverse = array_reverse($explode);
                $fileName = array_pop($reverse);
                $name = Utils::slug($fileName, '_');
                $extName = array_pop($explode);
                $fileSlug = $name . '.' . $extName;

                $fileName = date("Y-m-d_H-i-s") . '_' . $fileSlug; 
                $file->setExtensions(array('jpg', 'jpeg', 'png'));
                $path = dirname($_SERVER['SCRIPT_FILENAME']) . '/img/upload/apps/';
                $file->setPath($path);

                if ($file->isUploaded()) {
                    if ($file->save($fileName)) {
                        $app->logo = $fileName;
                        if ($app->save()) {
                            $app->commit();
                            Flash::valid('App Added Succesfully !');                            
                            if (!Input::isAjax()) {
                                return Router::redirect();
                            }
                        } else {
                            $app->rollback();
                            $file->remove($path, $fileName);
                            Flash::warning('An Error has Ocurred When Trying to Add the App !');
                        }
                    } else {
                        $app->rollback();
                        Flash::warning('An Error has Ocurred When Trying to Update the Image!');
                    }
                }  // Fin tratamiento de archivos de imagenes	
                
            }
        } catch (Exception $ex) {
            View::excepcion($ex);
        }
    }
    
    //Edit App
    public function edit($id){
        View::select('add');
        
        (int)$id;
        $app = new Apps();
        $this->app = $app->find_first($id);
        
        $this->title = 'Edit ' . $this->app->name . ' App';
        $this->logo = $this->app->logo;
        
        try{
            if($this->app){       
                if(Input::post('app')){
                    $app = new Apps(Input::post('app'));
                    $app->begin();
                    
                    if($_FILES["logo"]["name"] != null || $_FILES["logo"]["name"] != ''){
                        // Tratamiento de archivos de imagenes
                        $file = Upload::factory('logo', 'image');
                        $baseName = basename($_FILES["logo"]['name']);
                        $explode = explode(".", $baseName);
                        $reverse = array_reverse($explode);
                        $fileName = array_pop($reverse);
                        $name = Utils::slug($fileName, '_');
                        $extName = array_pop($explode);
                        $fileSlug = $name . '.' . $extName;

                        $fileName = date("Y-m-d_H-i-s") . '_' . $fileSlug; 
                        $file->setExtensions(array('jpg', 'jpeg', 'png'));
                        $path = dirname($_SERVER['SCRIPT_FILENAME']) . '/img/upload/apps/';
                        $file->setPath($path);

                        if ($file->isUploaded()) {
                            if ($file->save($fileName)) {
                                $app->logo = $fileName;
                                if ($app->save()) {
                                    $app->commit();
                                    $file->remove($path, $this->logo);
                                    Flash::valid('App Added Succesfully !');                            
                                    if (!Input::isAjax()) {
                                        return Router::redirect();
                                    }
                                } else {
                                    $app->rollback();
                                    $file->remove($path, $fileName);
                                    Flash::warning('An Error has Ocurred When Trying to Add the App !');
                                }
                            } else {
                                $app->rollback();
                                Flash::warning('An Error has Ocurred When Trying to Update the Image!');
                            }
                        }  // Fin tratamiento de archivos de imagenes
                        
                    } else {
                        if($app->save()){
                            $app->commit();
                            Flash::valid('App Edited Succesfully !');                            
                            if (!Input::isAjax()) {
                                return Router::redirect();
                            }
                        } else {
                            $app->rollback();
                            $file->remove($path, $fileName);
                            Flash::warning('An Error has Ocurred When Trying to Edit the App !');
                        }
                    }
                }
            } else {
                Flash::error('No existe registro con id: ' . $id);
                return Router::redirect();
            }
        } catch (Exception $ex) {
            View::excepcion($ex);
        }
    }
    
    //View App
    public function view($id){
        View::select('add');
        
        (int)$id;
        $app = new Apps();
        $this->app = $app->find_first($id);
        
        $this->title = 'View ' . $this->app->name . ' App';
        $this->logo = $this->app->logo;
    }
        
}
