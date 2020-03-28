import _ from 'lodash';


export class InitialReducer {
    reduce(json, state) {
        console.log("committing", state.commits, json);
        state.commits = json;
        console.log("committed", state);
    }
}
