import React from 'react';
import {shallow} from 'enzyme';
import HeaderTitle from '../header_title.es6.jsx';

describe('HeaderTitle', () => {
  it('when completed', () => {
    var gameProps = {opponentName: "Kevin", isCompleted: true}
    var headerTitleNode = shallow(<HeaderTitle game={gameProps} />);

    expect(headerTitleNode.text()).toEqual("<CompletionBanner />");
  });

  it('when your turn', () => {
    var gameProps = {opponentName: "Kevin", isTurn: true}
    var headerTitleNode = shallow(<HeaderTitle game={gameProps} />);

    expect(headerTitleNode.text()).toEqual(`Play Concentration against ${gameProps.opponentName}.It's your turn! 😎`);
  });

  it('when their turn', () => {
    var gameProps = {opponentName: "Kevin", isTurn: false}
    var headerTitleNode = shallow(<HeaderTitle game={gameProps} />);

    expect(headerTitleNode.text()).toEqual(`Play Concentration against ${gameProps.opponentName}.It's ${gameProps.opponentName}'s turn. 😓`);
  });
});
