import "bootstrap";
import "jquery";
import { tabActive } from '../components/tabs';
import { toolTip } from '../components/tooltip';


tabActive();
if(document.getElementById("my-albums")){
  toolTip();
};

