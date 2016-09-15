class Till extends React.Component {

  constructor(props) {
    super(props);
    this.buyHandler = this.buyHandler.bind(this);
  }

  componentDidMount() {
    point = $('#point').val();
    statistics_path = $('#statistics').val();

    store.dispatch({
      type: 'UPDATE_SUM_ORDERS',
      sum_products: $('#sum_orders').val()
    });

    axios.get('/api/v1/products?point=' + point)
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
    statistics_path = null;
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

    products = JSON.stringify(products);

    axios.post('/api/v1/orders', {products, point})
      .then(function (response) {
        store.dispatch({
          type: 'UPDATE_SUM_ORDERS',
          sum_products: response.data
        });
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
            Object.keys(this.props.products).sort(function (a, b) {
              var nameA=this.props.products[a].title.toLowerCase(), nameB=this.props.products[b].title.toLowerCase();
              if (nameA < nameB)
                return -1;
              if (nameA > nameB)
                return 1;
              return 0;
            }.bind(this)).map(function (key) {
              return <TillProduct
                key={key}
                product={this.props.products[key]}
              />;
            }.bind(this))
          }
        </div>

        <div className="footer" style={ {display: common_price === 0 ? null : 'none'} }>
          <div className="container">
            <a href={statistics_path} className="elements">
              {this.props.sum_orders} ₽
            </a>
          </div>
        </div>

        <div className="footer-red" style={ {display: common_price === 0 ? 'none' : null} }>
          <div className="container">
            <div className="elements" onClick={this.buyHandler}>
              {common_price} ₽
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
    products: state.productState,
    sum_orders: state.sumOrdersState
  };
};

function mapDispatchToProps(dispatch) {
  return {
    pageActions: {}
  }
}

Till = ReactRedux.connect(mapStateToProps, mapDispatchToProps)(Till);


