import "bootstrap";
import "jquery";
import { tabActive } from '../components/tabs';
import { toolTip } from '../components/tooltip';

tabActive();
toolTip();
global.toolTip = toolTip;
