class Message extends React.Component {
  render () {
    if (this.props.message.content) {
      return (
        <div className={"alert alert-"+this.props.message.className}>
          <a href="#" data-dismiss="alert" className="close">×</a>
            <ul>
              <li>
                {this.props.message.content}
              </li>
            </ul>
        </div>
      );      
    } else {
      return null;
    }
  }
}
