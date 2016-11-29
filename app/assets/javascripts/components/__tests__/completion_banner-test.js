import React from 'react';
import {mount} from 'enzyme';
import CompletionBanner from '../completion_banner.es6.jsx';

it('CompletionBanner says tied after tie', () => {
  // Render a checkbox with label in the document
  var gameProps = {opponentName: "Kevin", isWinner: "tie"}
  var completionBannerNode = mount(<CompletionBanner game={gameProps} />);

  expect(completionBannerNode.find("h1").text()).toEqual(`Wow 🙃, you tied ${gameProps.opponentName}! 🤘`);
});

it('CompletionBanner says won after win', () => {
  // Render a checkbox with label in the document
  var gameProps = {opponentName: "Kevin", isWinner: "winner"}
  var completionBannerNode = mount(<CompletionBanner game={gameProps} />);

  expect(completionBannerNode.find("h1").text()).toEqual(`Congrats 🏅 you beat ${gameProps.opponentName}! 👏`);
});

it('CompletionBanner says lost after loss', () => {
  // Render a checkbox with label in the document
  var gameProps = {opponentName: "Kevin", isWinner: "loser"}
  var completionBannerNode = mount(<CompletionBanner game={gameProps} />);

  expect(completionBannerNode.find("h1").text()).toEqual(`I'm sorry 😿, but you lost to ${gameProps.opponentName}. 👎`);
});
