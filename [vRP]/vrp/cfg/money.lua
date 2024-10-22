local cfg = {}

cfg.open_wallet = 200000
cfg.open_bank = 20000
cfg.open_xzCoins = 0
cfg.open_diamonds = 0

cfg.display_css = [[
  .div_money{
    position: absolute;
    top: 40px;
    right: 10px;
    width: 170px;
    text-align: right;
    background-image: url("https://cdn2.steamgriddb.com/file/sgdb-cdn/hero_thumb/f8f656b73252c75518351df0289a43cc.jpg");
    -- background-repeat: no-repeat;
    -- background-size: 100% 100%;
    padding: 7px;
    border-bottom-left-radius: 10px;
    border-top-right-radius: 10px;
    max-width: 170px;
    font-size: 15px;
    -- border-radius: 10px;
    border-left: 2px solid #710f85;
    border-right: 2px solid #710f85;
    font-weight: bold;
    font-family: "Comic Sans MS", cursive, sans-serif;
    color: #FFFFFF;
    text-shadow: 1px 1px 1px black;
  } 

  .div_bmoney{
    position: absolute;
    top: 80px;
    right: 10px;
    width: 170px;
    text-align: right;
    background-image: url("https://cdn2.steamgriddb.com/file/sgdb-cdn/hero_thumb/f8f656b73252c75518351df0289a43cc.jpg");
    -- background-repeat: no-repeat;
    -- background-size: 100% 100%;
    padding: 7px;
    border-left: 2px solid #710f85;
    border-right: 2px solid #710f85;
    border-bottom-left-radius: 10px;
    border-top-right-radius: 10px;
    max-width: 170px;
    font-size: 15px;
    font-weight: bold;
    font-family: "Comic Sans MS", cursive, sans-serif;
    color: #FFFFFF;
    text-shadow: 1px 1px 1px black;
  }

  .div_krCoins{
    position: absolute;
    top: 120px;
    right: 10px;
    width: 170px;
    text-align: right;
    background-image: url("https://cdn2.steamgriddb.com/file/sgdb-cdn/hero_thumb/f8f656b73252c75518351df0289a43cc.jpg");
    -- background-repeat: no-repeat;
    -- background-size: 100% 100%;
    padding: 7px;
    border-bottom-left-radius: 10px;
    border-top-right-radius: 10px;
    border-left: 2px solid #710f85;
    border-right: 2px solid #710f85;
    max-width: 170px;
    font-size: 15px;
    font-weight: bold;
    font-family: "Comic Sans MS", cursive, sans-serif;
    color: #FFFFFF;
    text-shadow: 1px 1px 1px black;
  }


  
  .div_money .symbol{
    position:absolute;
    content: url('https://media.discordapp.net/attachments/826161097857171497/917122189021569034/output-onlinepngtools_4.png'); 
    left: 11px;
    width: 21px;
    height: 21px;
    top: 6px;

  }
  
  .div_bmoney .symbol{
    position:absolute;
    content: url('https://cdn.discordapp.com/attachments/893561902171557918/893609640242327582/credit-card.png');
    left: 11px;
    width: 20px;
    height: 20px;
    top: 5px;

  }
  .div_krCoins .symbol{
    position:absolute;
    content: url('https://media.discordapp.net/attachments/826161097857171497/917119633402777620/output-onlinepngtools.png');
    left: 11px;
    width: 20px;
    height: 20px;
    top: 5px;

  }


  
]]

return cfg