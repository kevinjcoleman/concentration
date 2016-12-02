import React from 'react';
import ReactDOM from 'react-dom';

class GameBoard extends React.Component {
  render() {
    var cardNodes = this.props.cards.map(function (card, index) {
      return (
        <Card card={card}
              key={index}
              order={index}
              isTurn={this.props.isTurn}
              onClick={this.props.handleClick}/>
      );
    }, this);

    return (
      <div className="cards row">
        {cardNodes}
      </div>
    );
  }
}

export default GameBoard
