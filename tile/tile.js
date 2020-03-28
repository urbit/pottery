import React, { Component } from 'react';
import _ from 'lodash';


export default class potteryTile extends Component {

  render() {
    return (
      <div className="w-100 h-100 relative bg-white bg-gray0-d ba b--black b--gray1-d">
        <a className="w-100 h-100 db pa2 no-underline" href="/~pottery">
          <p className="black white-d absolute f9" style={{ left: 8, top: 8 }}>pottery</p>
          <img className="absolute" src="/~pottery/img/Tile.png" style={{top: 48, left: 48}}/>
        </a>
      </div>
    );
  }

}

window.potteryTile = potteryTile;
