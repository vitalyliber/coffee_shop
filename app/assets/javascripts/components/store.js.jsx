Provider = ReactRedux.Provider;
render = ReactDOM.render;

const initialProductState = {
  products: {}
};

var productReducer = function(state = initialProductState, action) {
  switch(action.type) {

  case 'SELECT_PRODUCT':
    newState = update(state, {
      [action.product_id]: {active: {$set: true} }
    });
    return newState;

  case 'NORMALIZE_PRODUCT':
    $.each( state, function( key, value ) {
      newState = update(newState, {
        [key]: {active: {$set: false} }
      });
      newState = update(newState, {
        [key]: {$merge: {repeat: 1} }
      });
    });

    return newState;

  case 'DESELECT_PRODUCT':
    newState = update(state, {
      [action.product_id]: {active: {$set: false} }
    });
    newState = update(newState, {
      [action.product_id]: {$merge: {repeat: 1} }
    });
    return newState;

  case 'FILL_PRODUCT':
    newState = action.products;
    return newState;

  case 'ADD_REPEAT':
    repeat = state[action.product_id].repeat;
    newState = update(state, {
      [action.product_id]: {$merge: {repeat: repeat + 1} }
    });
    return newState;

  case 'REMOVE_REPEAT':
    repeat = state[action.product_id].repeat;
    if (repeat !== 1) {
      newState = update(state, {
        [action.product_id]: {$merge: {repeat: repeat - 1} }
      });
    return newState;
    }

  default:
    return state;
  }
};

const reducers = Redux.combineReducers({
  productState: productReducer
});

// Create a store by passing in the reducer
var store = Redux.createStore(reducers);
