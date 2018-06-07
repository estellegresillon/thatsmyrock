import "bootstrap";
import "jquery";
import { tabActive } from '../components/tabs';
import { toolTip } from '../components/tooltip';
import { scrollFunction } from '../components/scroll_to_top';

tabActive();
toolTip();
global.toolTip = toolTip;
scrollFunction();
