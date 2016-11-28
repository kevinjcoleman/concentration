require( 'babel-polyfill' );

window.Game = global.Game = require("./components/game.es6.jsx").default;
window.Header = global.Header = require("./components/header.es6.jsx").default;
window.ScoreProgress = global.ScoreProgress = require("./components/score_progress.es6.jsx").default;
window.HeaderScoreboard = global.HeaderScoreboard = require("./components/header_Scoreboard.es6.jsx").default;
window.HeaderTitle = global.HeaderTitle = require("./components/header_title.es6.jsx").default;
window.GameBoard = global.GameBoard = require("./components/game_board.es6.jsx").default;
window.Card = global.Card = require("./components/card.es6.jsx").default;
window.Message = global.Message = require("./components/message.es6.jsx").default;
window.CompletionBanner = global.CompletionBanner = require("./components/completion_banner.es6.jsx").default;
