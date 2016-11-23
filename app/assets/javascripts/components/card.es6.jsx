function CardTile(props) {
  return (
    <div className={"card col-lg-2 col-md-3 col-sm-4 col-xs-6 well text-center "+ props.className} onClick={props.handleClick}>
      {props.unicode ? props.unicode : ''}
    </div>
  );
}

class Card extends React.Component {

  constructor(props) {
      super(props);
      this.state = {isFlipped: false};
  }

  handleClick(e) {
    e.preventDefault();
    console.log('The link was clicked.');
    this.setState({isFlipped: !this.state.isFlipped});
    this.props.onClick();
  }

//This is preventing cards from flipping over at all.
  componentWillReceiveProps(nextProps) {
    this.setState({ isFlipped: nextProps.isFlipped });
  }

  render() {
    if (this.props.isGuessed) {
      return (
        <CardTile unicode={this.props.unicode} 
          className="flipped" /> 
      );
    }
    else if (this.state.isFlipped) {
      return (
        <CardTile unicode={this.props.unicode} 
          className="flipped"
          handleClick={this.handleClick.bind(this)} /> 
        );
    }
      return (
        <CardTile className="covered"
          handleClick={this.handleClick.bind(this)} />  
      );
  }
}