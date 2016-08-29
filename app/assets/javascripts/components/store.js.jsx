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
  case 'DESELECT_PRODUCT':
    newState = update(state, {
      [action.product_id]: {active: {$set: false} }
    });
    return newState;
    case 'FILL_PRODUCT':
      newState = action.products;
      return newState;
    default:
      return state;
  }
};

const reducers = Redux.combineReducers({
  productState: productReducer
});

// Create a store by passing in the reducer
var store = Redux.createStore(reducers);
