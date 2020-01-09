<?php


class Apps extends ActiveRecord
{

    //protected $debug = "true";
    
    protected function initialize()
    {	
        //validaciones
        $this->validates_presence_of('name','message: El campo <b>Nombre de la App</b> es obligatorio.');
        $this->validates_presence_of('folder','message: El campo <b>Folder</b> es obligatorio.');
        $this->validates_presence_of('status','message: El campo <b>Status</b> es obligatorio.');
    }

	
    protected function before_save()
    {
        
    }

}
