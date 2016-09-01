products_from_string = JSON.parse("[{\"id\":2,\"active\":null,\"title\":\"Американо\",\"description\":null,\"price\":90,\"created_at\":\"2016-07-23T17:03:22.873Z\",\"updated_at\":\"2016-08-13T16:53:56.086Z\",\"ml\":200},{\"id\":3,\"active\":null,\"title\":\"Капучино\",\"description\":null,\"price\":110,\"created_at\":\"2016-07-23T17:03:30.850Z\",\"updated_at\":\"2016-08-13T16:53:56.088Z\",\"ml\":200},{\"id\":4,\"active\":null,\"title\":\"Капучино\",\"description\":null,\"price\":130,\"created_at\":\"2016-08-13T16:53:56.090Z\",\"updated_at\":\"2016-08-13T16:53:56.090Z\",\"ml\":400},{\"id\":5,\"active\":null,\"title\":\"Латте\",\"description\":null,\"price\":120,\"created_at\":\"2016-08-13T16:53:56.091Z\",\"updated_at\":\"2016-08-13T16:53:56.091Z\",\"ml\":200},{\"id\":6,\"active\":null,\"title\":\"Латте\",\"description\":null,\"price\":140,\"created_at\":\"2016-08-13T16:53:56.093Z\",\"updated_at\":\"2016-08-13T16:53:56.093Z\",\"ml\":400},{\"id\":7,\"active\":null,\"title\":\"Мокаччино\",\"description\":null,\"price\":130,\"created_at\":\"2016-08-13T16:53:56.094Z\",\"updated_at\":\"2016-08-13T16:53:56.094Z\",\"ml\":200},{\"id\":8,\"active\":null,\"title\":\"Мокаччино\",\"description\":null,\"price\":140,\"created_at\":\"2016-08-13T16:53:56.096Z\",\"updated_at\":\"2016-08-13T16:53:56.096Z\",\"ml\":400},{\"id\":9,\"active\":null,\"title\":\"Раф кофе\",\"description\":null,\"price\":130,\"created_at\":\"2016-08-13T16:53:56.097Z\",\"updated_at\":\"2016-08-13T16:53:56.097Z\",\"ml\":200},{\"id\":10,\"active\":null,\"title\":\"Раф кофе\",\"description\":null,\"price\":140,\"created_at\":\"2016-08-13T16:53:56.107Z\",\"updated_at\":\"2016-08-13T16:53:56.107Z\",\"ml\":400},{\"id\":11,\"active\":null,\"title\":\"Какао\",\"description\":null,\"price\":60,\"created_at\":\"2016-08-13T16:53:56.108Z\",\"updated_at\":\"2016-08-13T16:53:56.108Z\",\"ml\":200},{\"id\":12,\"active\":null,\"title\":\"Какао\",\"description\":null,\"price\":100,\"created_at\":\"2016-08-13T16:53:56.110Z\",\"updated_at\":\"2016-08-13T16:53:56.110Z\",\"ml\":400},{\"id\":13,\"active\":null,\"title\":\"Горячий шоколад\",\"description\":null,\"price\":140,\"created_at\":\"2016-08-13T16:53:56.111Z\",\"updated_at\":\"2016-08-13T16:53:56.111Z\",\"ml\":200},{\"id\":14,\"active\":null,\"title\":\"Горячий шоколад\",\"description\":null,\"price\":160,\"created_at\":\"2016-08-13T16:53:56.113Z\",\"updated_at\":\"2016-08-13T16:53:56.113Z\",\"ml\":400},{\"id\":15,\"active\":null,\"title\":\"Растворимый кофе\",\"description\":null,\"price\":40,\"created_at\":\"2016-08-13T16:53:56.114Z\",\"updated_at\":\"2016-08-13T16:53:56.114Z\",\"ml\":200},{\"id\":16,\"active\":null,\"title\":\"Растворимый кофе\",\"description\":null,\"price\":60,\"created_at\":\"2016-08-13T16:53:56.116Z\",\"updated_at\":\"2016-08-13T16:53:56.116Z\",\"ml\":400},{\"id\":17,\"active\":null,\"title\":\"Лимонад\",\"description\":null,\"price\":80,\"created_at\":\"2016-08-13T16:53:56.117Z\",\"updated_at\":\"2016-08-13T16:53:56.117Z\",\"ml\":200},{\"id\":18,\"active\":null,\"title\":\"Лимонад\",\"description\":null,\"price\":100,\"created_at\":\"2016-08-13T16:53:56.118Z\",\"updated_at\":\"2016-08-13T16:53:56.118Z\",\"ml\":400},{\"id\":19,\"active\":null,\"title\":\"Пепси\",\"description\":null,\"price\":60,\"created_at\":\"2016-08-13T16:53:56.120Z\",\"updated_at\":\"2016-08-13T16:53:56.120Z\",\"ml\":600},{\"id\":20,\"active\":null,\"title\":\"Вода\",\"description\":null,\"price\":50,\"created_at\":\"2016-08-13T16:53:56.122Z\",\"updated_at\":\"2016-08-13T16:53:56.122Z\",\"ml\":500},{\"id\":21,\"active\":null,\"title\":\"Чай\",\"description\":null,\"price\":40,\"created_at\":\"2016-08-13T16:53:56.123Z\",\"updated_at\":\"2016-08-13T16:53:56.123Z\",\"ml\":200},{\"id\":22,\"active\":null,\"title\":\"Чай\",\"description\":null,\"price\":60,\"created_at\":\"2016-08-13T16:53:56.124Z\",\"updated_at\":\"2016-08-13T16:53:56.124Z\",\"ml\":400}]");

class Till extends React.Component {

  constructor(props) {
    super(props);
    this.buyHandler = this.buyHandler.bind(this);
  }

  componentDidMount() {
    normalize_products = normalize(products_from_string, arrayOfProducts).entities.product;

    store.dispatch({
      type: 'FILL_PRODUCT',
      products: normalize_products
    });

    store.dispatch({
      type: 'NORMALIZE_PRODUCT',
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
    products = store.getState('products').productState;

    let bought_products = {products: {}};

    $.each( products, function( key, value ) {
      if (value.active === true) {
        bought_products = update(bought_products, {
          products: {$merge: {[value.id]: value.repeat} }
        });
      }
    });

    console.log( JSON.stringify(bought_products) )
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
              <button onClick={this.buyHandler} className="cost btn btn-primary">{common_price} ₽</button>
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


