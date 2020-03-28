import { Gitgraph, templateExtend, TemplateName } from "@gitgraph/react";
import React, { Component } from 'react';
import { BrowserRouter, Route } from "react-router-dom";
import _ from 'lodash';
import { store } from '/store';
import { HeaderBar } from "./lib/header-bar.js"



export class Root extends Component {
  constructor(props) {
    super(props);
    this.state = store.state;
    store.setStateHandler(this.setState.bind(this));

    this.clickety = this.clickety.bind(this);
    this.graph = this.graph.bind(this);
    this.template = templateExtend(TemplateName.Metro, {
      branch: {
        lineWidth: 6,
      },
      commit: {
        spacing: 40,
        dot: {
          size: 10,
        },
        message: {
          displayAuthor: false,
          font: "normal 16pt monospace",
        }
      },
    });
  }

  clickety() {
    console.log(this.state.gitgraph);
    console.log("commits",this.state.commits);
    let { commits, gitgraph } = this.state;
    if ( !commits.commits ) return;

    let commitMap = {};

    commits.commits.forEach(commit => {
      commitMap[commit.commitHash] = commit;
    });

    let data = commits.commits.map(com => {
      console.log(com.commitHash,commits.head);
      let ref = [];
      if (com.commitHash in commits.head) {
        ref = ["HEAD", commits.head[com.commitHash]];
      }
      return {
        refs: ref,
        hash: com.commitHash.slice(-5),
        hashAbbrev: com.commitHash.slice(-5),
        parents: com.parents.map(par => {return par.slice(-5);}),
        parentsAbbrev: com.parents.map(par => {return par.slice(-5);}),
        subject: "content: " +
                  com.contentHash.slice(-5) +
                  ", parents: " +
                  com.parents.map(par => {return par.slice(-5);}),
        author: {
          name: "me",
          email: "me",
          timestamp: 1500000000000,
    } } });
    gitgraph.import(data);
  }

  graph(gitgraph) {
    this.setState({gitgraph: gitgraph});
    this.clickety();
  }


  render() {

    return (
      <BrowserRouter>
        <div className="absolute w-100 bg-gray0-d ph4-m ph4-l ph4-xl pb4-m pb4-l pb4-xl">
        <HeaderBar/>
        <Route exact path="/~pottery" render={ () => {
          return (
            <div className="cf w-100 flex flex-column pa4 ba-m ba-l ba-xl b--gray2 br1 h-100 h-100-minus-40-m h-100-minus-40-l h-100-minus-40-xl f9 white-d">
              <h1 className="mt0 f8 fw4">pottery</h1>
              <p className="lh-copy measure pt3">Once this page has finished loading, press "Visualize!"</p>
              <button
                className="lh-copy measure pt3"
                onClick={this.clickety}>
                Visualize!
              </button>
            <Gitgraph options={{template: this.template}}>{this.graph}</Gitgraph>
            </div>
          )}}
        />
        </div>
      </BrowserRouter>
    )
  }
}


