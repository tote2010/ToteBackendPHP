
gaston@itgapps.com

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
 * @package Modelos
 * @license http://www.gnu.org/licenses/agpl.txt GNU AFFERO GENERAL PUBLIC LICENSE version 3.
 * @author TOTE || Gastón Diego Mascialino <gaston@itgapps.com>
 */

class Empresa extends ActiveRecord
{

    protected function initialize()
    {	
        //validaciones
        $this->validates_presence_of('nombre','message: El campo <b>Nombre de la Empresa</b> es obligatorio.');
        $this->validates_presence_of('domicilio','message: El campo <b>Domicilio</b> es obligatorio.');
        $this->validates_presence_of('telefono1','message: El campo <b>Teléfono 1</b> es obligatorio.');
        $this->validates_presence_of('cuit','message: El campo <b>C.U.I.T.</b> es obligatorio.');
    }

	
    protected function before_save()
    {
        
    }

}
