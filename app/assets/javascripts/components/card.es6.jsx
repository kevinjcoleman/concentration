function CardTile(props) {
  return (
    <div className={"card col-lg-2 col-md-3 col-sm-4 col-xs-6 well text-center "+ props.className} onClick={props.handleClick}>
      {props.unicode ? props.unicode : ''}
    </div>
  );
}

class Card extends React.Component {
  render() {
    if (!this.props.isTurn && !(this.props.isGuessed || this.props.isFlipped)) {
      return (
        <CardTile className="covered" /> 
      );
    }
    else if (this.props.isGuessed) {
      return (
        <CardTile unicode={this.props.unicode} 
          className="flipped" /> 
      );
    }
    else if (this.props.isFlipped) {
      return (
        <CardTile unicode={this.props.unicode} 
          className="flipped" /> 
        );
    }
    return (
      <CardTile className="covered"
        handleClick={this.props.onClick} />  
    );
  }
}