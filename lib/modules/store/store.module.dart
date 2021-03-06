import 'package:flutter_modular/flutter_modular.dart';
import 'package:xtintas/infra/http/http_client.dart';
import 'package:xtintas/modules/cart/adapters/paint_cart_adapter.dart';
import 'package:xtintas/modules/cart/data/remote_cart_usecases.dart';
import 'package:xtintas/modules/cart/domain/usecases/cart_usecase.dart';
import 'package:xtintas/modules/store/adapters/adapters.dart';
import 'package:xtintas/modules/store/adapters/ink.adapters.dart';
import 'package:xtintas/modules/store/data/usecases/usecases.dart';
import 'package:xtintas/modules/store/domain/usecases/store_usecase.dart';
import 'package:xtintas/presenter/page/how_paint.page.dart';
import 'package:xtintas/presenter/page/store.page.dart';

class StoreModule extends Module {
  @override
  List<Bind> get binds => [
        Bind.factory<StoreAdapters>((i) => StoreAdapters()),
        Bind.factory<InkAdapter>((i) => InkAdapter()),
        Bind.factory<PaintCartAdapter>((i) => PaintCartAdapter()),
        Bind.factory<IStoreUseCase>((i) => RemoteStoreUseCases(
            httpClient: Modular.get<IHttpClient>(), adapter: i<StoreAdapters>())),
        Bind.factory<ICartUseCases>(
          (i) => RemoteCartUseCase(
            httpClient: i<HttpClient>(),
            inkAdapter: i<InkAdapter>(),
            paintAdapter: i<PaintCartAdapter>(),
          ),
        )
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          "/",
          child: (context, args) => const StorePage(),
          transition: TransitionType.leftToRightWithFade,
        ),
        ChildRoute("/how_paint", child: (context, args) => const HowPaint())
      ];
}
