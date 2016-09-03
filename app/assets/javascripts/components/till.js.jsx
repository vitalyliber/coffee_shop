class Till extends React.Component {

  constructor(props) {
    super(props);
    this.buyHandler = this.buyHandler.bind(this);
  }

  componentDidMount() {

    axios.get('/api/v1/products')
      .then(function (response) {

        let products_from_api = response.data.products;

        normalize_products = normalize(products_from_api, arrayOfProducts).entities.product;

        store.dispatch({
          type: 'FILL_PRODUCT',
          products: normalize_products
        });

        store.dispatch({
          type: 'NORMALIZE_PRODUCT',
        });

      })
      .catch(function (error) {
        console.log(error);
      });
  }

  componentWillMount() {
    common_price = 0;
  }

  componentWillReceiveProps () {
    products = store.getState('products').productState;

    common_price = 0;

    $.each( products, function( key, value ) {
      if (value.active === true) {
        let price = value.price;
        let repeat = value.repeat;
        common_price = common_price + price * repeat;
      }
    });
  }

  buyHandler () {
    state_products = store.getState('products').productState;

    let products = {products: []};

    $.each( state_products, function( key, value ) {
      if (value.active === true) {
        products.products.push({id: value.id, repeat: value.repeat})
      }
    });

    store.dispatch({
      type: 'NORMALIZE_PRODUCT',
    });

    console.log(products);

    axios.post('/api/products/sale', {products})
      .then(function (response) {
        console.log(response);
      })
      .catch(function (error) {
        console.log(error);
    });
  }

  render() {
    return (
      <div>
        <div className="container">
          {
            Object.keys(this.props.products).map(function (key) {
              return <TillProduct
                key={key}
                product={this.props.products[key]}
              />;
            }.bind(this))
          }
        </div>
        <div className="footer">
          <div className="container">
            <div className="elements">
              <button onClick={this.buyHandler}
                      disabled={common_price === 0 }
                      className="cost btn btn-primary">{common_price} ₽</button>
            </div>
          </div>

        </div>

      </div>

    );
  }
}

document.addEventListener("turbolinks:load", function() {
  if ($("#root").length) {

    render(
      <Provider store={store}>
        <Till />
      </Provider>,
      document.getElementById('root')
    );

  }
});

document.addEventListener("turbolinks:before-cache", function() {
  if ($("#root").length) {

    ReactDOM.unmountComponentAtNode(document.getElementById('root'));

  }
});

const mapStateToProps = (state) => {
  return {
    products: state.productState
  };
};

function mapDispatchToProps(dispatch) {
  return {
    pageActions: {}
  }
}

Till = ReactRedux.connect(mapStateToProps, mapDispatchToProps)(Till);


