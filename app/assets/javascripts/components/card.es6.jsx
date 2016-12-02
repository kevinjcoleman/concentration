import React from 'react';
import ReactDOM from 'react-dom';
import ReactCSSTransitionGroup from 'react-addons-css-transition-group'
import $ from 'jquery';

function CardTile(props) {
  return (
    <div>
      <ReactCSSTransitionGroup
        transitionName="example"
        transitionAppear={true}
        transitionAppearTimeout={500}
        transitionEnterTimeout={500}
        transitionLeaveTimeout={500}>
        <div className={"card col-lg-2 col-md-3 col-sm-4 col-xs-6 well text-center "+ props.className} onClick={props.handleClick}>
          {props.unicode ? props.unicode : <img className="diamond" src={props.imageUrl}></img>}
        </div>
      </ReactCSSTransitionGroup>
    </div>
  );
}

class Card extends React.Component {
  constructor(props) {
    super(props);
    this.handleClick = this.handleClick.bind(this);
    var unicode = this.props.card.unicode ? this.props.card.unicode : ''
    this.state = { id: this.props.card.id,
                   isFlipped: this.props.card.isFlipped,
                   unicode: unicode,
                   name: ''};
  }

  handleClick() {
    console.log("Loading card image from server.");
    $.ajax({
      url: "/cards/"+this.state.id,
      dataType: 'json',

      success: function (results) {
        console.log("Successfully aquired logo.")
        this.setState({unicode: results.card.unicode,
                       name: results.card.name,
                       isFlipped: true});
       this.props.onClick({id: this.state.id,
                           name: results.card.name});
      }.bind(this),

      error: function (xhr, status, err) {
        console.error(status, err.toString());
      }.bind(this)
    });
  }

  componentWillReceiveProps(nextProps) {
    if (nextProps.card.isFlipped != this.state.isFlipped) {
      this.setState({ isFlipped: nextProps.card.isFlipped });
    }
    else if (this.props.isTurn == false && nextProps.card.unicode != this.state.unicode) {
      this.setState({ unicode: nextProps.card.unicode });
    }
  }

  render() {
    //Alternate background colors of covered cards.
    var coveredClass = `covered ${this.props.order % 2 ? "red-covered" : "blue-covered"}`;
    //If it is not the current players turn AND the card has not been guessed or is not
    //currently flipped(One of the players 2 guesses that stays up at the end of the turn),
    //Keep the cards flipped over and don't add an onclick function.
    if (!this.props.isTurn && !(this.props.card.isGuessed || this.state.isFlipped)) {
      return (<CardTile className={coveredClass}
                        imageUrl={this.props.card.coveredImageUrl} />);
    }
    //If the card is guessed leave it flipped over and add a class to the card based on
    //whether the current player picked it or not.
    else if (this.props.card.isGuessed) {
      var pickClass = this.props.card.pickedByCurrentPlayer ? "blue" : "red"
      return (<CardTile unicode={this.state.unicode}
                        className={"flipped " + pickClass} />);
    }
    //If the card is flipped this turn, flip it over with a key so that it has a transition in and out.
    else if (this.state.isFlipped) {
      return (<CardTile key={`$this.props.card.id-flipped`}
                        unicode={this.state.unicode}
                        className="flipped" />);
    }
    // If none of the conditions are met keep the card covered and and add an onclick function.
    return (<CardTile className={coveredClass}
                      handleClick={this.handleClick}
                      imageUrl={this.props.card.coveredImageUrl} />);
  }
}

export default Card
