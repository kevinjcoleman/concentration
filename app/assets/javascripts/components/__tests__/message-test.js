import React from 'react';
import {shallow} from 'enzyme';
import Message from '../message.es6.jsx';

describe('Message', () => {
  it('when success', () => {
    // Render a checkbox with label in the document
    var messageProps = {content: "You were successful",
                     className: 'success'}
    var message = shallow(<Message message={messageProps} />);

    expect(message.find(".alert-success").length).toEqual(1);
    expect(message.find('li').text()).toEqual(messageProps.content);
  });

  it('when danger', () => {
    // Render a checkbox with label in the document
    var messageProps = {content: "You were not successful",
                     className: 'danger'}
    var message = shallow(<Message message={messageProps} />);

    expect(message.find(".alert-danger").length).toEqual(1);
    expect(message.find('li').text()).toEqual(messageProps.content);
  });
});
