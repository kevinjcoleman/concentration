import React from 'react';
import {shallow} from 'enzyme';
import HeaderTitle from '../header_title.es6.jsx';

it('HeaderTitle renders CompletionBanner when completed', () => {
  var gameProps = {opponentName: "Kevin", isCompleted: true}
  var headerTitleNode = shallow(<HeaderTitle game={gameProps} />);

  expect(headerTitleNode.text()).toEqual("<CompletionBanner />");
});

it('HeaderTitle renders its your turn', () => {
  var gameProps = {opponentName: "Kevin", isTurn: true}
  var headerTitleNode = shallow(<HeaderTitle game={gameProps} />);

  expect(headerTitleNode.text()).toEqual(`Play Concentration against ${gameProps.opponentName}.It's your turn! 😎`);
});

it('HeaderTitle renders its their turn', () => {
  var gameProps = {opponentName: "Kevin", isTurn: false}
  var headerTitleNode = shallow(<HeaderTitle game={gameProps} />);

  expect(headerTitleNode.text()).toEqual(`Play Concentration against ${gameProps.opponentName}.It's ${gameProps.opponentName}'s turn. 😓`);
});
