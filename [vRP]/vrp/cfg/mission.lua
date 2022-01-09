local cfg = {}
 
-- mission display css
cfg.display_css = [[
.div_mission{
  position: absolute;
    top: 110px;
    right: 10px;
    width: 225px;
    text-align: right;
    background: linear-gradient(to left, rgba(126, 43, 255, 0.5), rgba(0,0,0,0));
    padding: 4px;
    max-width: 200px;
    border-radius: 2px;
    font-size: 15px;
    font-family: 'Arial ';
    color: #FFFFFF;
    text-shadow: 1px 1px 1px ;
    border-top: 4px solid white;
}
 
.div_mission .name{
  color: rgb(255,255,255);
  font-weight: bold;
}
 
.div_mission .step{
  color: rgb(255,255,255);
  font-weight: bold;
}
 
@-moz-keyframes jump {
  0% {
    top: 125px;
  }
  50% {
    top: 145px;
  }
  100% {
    top: 125px;
  }
}
 
@-webkit-keyframes jump {
  0% {
    top: 125px;
  }
  50% {
    top: 145px;
  }
  100% {
    top: 125px;
  }
}
]]

return cfg