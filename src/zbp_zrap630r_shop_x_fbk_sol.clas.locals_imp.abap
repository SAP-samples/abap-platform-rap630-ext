*"* use this source file for the definition and implementation of
*"* local helper classes, interface definitions and type
*"* declarations
CLASS lhc_shop DEFINITION INHERITING FROM cl_abap_behavior_handler.

  PUBLIC SECTION.
    CONSTANTS state_area_check_delivery_date       TYPE string VALUE 'CHECK_DELIVERYDATE'       ##NO_TEXT.
  PRIVATE SECTION.
    METHODS zz_validateDeliverydate               FOR VALIDATE ON SAVE
      IMPORTING keys FOR Shop~zz_validateDeliverydate.
    METHODS ZZ_setOverallStatus FOR DETERMINE ON MODIFY
      IMPORTING keys FOR Shop~ZZ_setOverallStatus.
    METHODS get_instance_features FOR INSTANCE FEATURES
      IMPORTING keys REQUEST requested_features FOR Shop RESULT result.

    METHODS get_global_authorizations FOR GLOBAL AUTHORIZATION
      IMPORTING REQUEST requested_authorizations FOR Shop RESULT result.

    METHODS ZZ_ProvideFeedback FOR MODIFY
      IMPORTING keys FOR ACTION Shop~ZZ_ProvideFeedback RESULT result.

ENDCLASS.

CLASS lhc_shop IMPLEMENTATION.

  METHOD zz_validateDeliverydate.
    READ ENTITIES OF ZRAP630i_ShopTP_sol IN LOCAL MODE
            ENTITY Shop
            FIELDS ( DeliveryDate OverallStatus )
            WITH CORRESPONDING #( keys )
            RESULT DATA(onlineorders).

    LOOP AT onlineorders INTO DATA(onlineorder).
      APPEND VALUE #( %tky           = onlineorder-%tky
                      %state_area    = state_area_check_delivery_date )
             TO reported-shop.
      DATA(deliverydate)             =  onlineorder-DeliveryDate - cl_abap_context_info=>get_system_date(  ).
      IF onlineorder-deliverydate IS INITIAL  .
        APPEND VALUE #( %tky           = onlineorder-%tky ) TO failed-shop.
        APPEND VALUE #( %tky           = onlineorder-%tky
                        %state_area    = state_area_check_delivery_date
                        %msg           = new_message_with_text(
                                            severity = if_abap_behv_message=>severity-error
                                            text     = 'delivery period cannot be initial'
                       ) )
                TO reported-shop.
      ENDIF.
    ENDLOOP.
  ENDMETHOD.
  METHOD ZZ_setOverallStatus.
  DATA update_bo      TYPE TABLE FOR UPDATE     ZRAP630i_ShopTP_sol\\Shop.
 DATA update_bo_line TYPE STRUCTURE FOR UPDATE ZRAP630i_ShopTP_sol\\Shop .

 READ ENTITIES OF ZRAP630I_ShopTP_sol IN LOCAL MODE
   ENTITY Shop
     ALL FIELDS " ( OrderItemPrice OrderID )
     WITH CORRESPONDING #( keys )
   RESULT DATA(OnlineOrders)
   FAILED DATA(onlineorders_failed)
   REPORTED DATA(onlineorders_reported).

 DATA(product_value_help) = NEW zrap630_cl_vh_product_sol(  ).
 data(products) = product_value_help->get_products(  ).

 LOOP AT onlineorders INTO DATA(onlineorder).

   update_bo_line-%tky = onlineorder-%tky.

   IF onlineorder-OrderItemPrice > 1000.
     update_bo_line-OverallStatus = 'Awaiting approval'.
   ELSE.
     update_bo_line-OverallStatus = 'Automatically approved'.
   ENDIF.

   SELECT SINGLE * FROM @products as hugo
      WHERE Product = @onlineorder-OrderedItem  INTO @data(product).

   update_bo_line-OrderItemPrice = product-Price.
   update_bo_line-CurrencyCode = product-Currency.

   APPEND update_bo_line TO update_bo.
 ENDLOOP.


 MODIFY ENTITIES OF zrap630i_shoptp_sol IN LOCAL MODE
   ENTITY Shop
     UPDATE FIELDS (
     OverallStatus
     CurrencyCode
     OrderItemPrice
     )
     WITH update_bo
    REPORTED DATA(update_reported).

 reported = CORRESPONDING #( DEEP update_reported ).

  ENDMETHOD.

  METHOD get_instance_features.
  ENDMETHOD.

  METHOD get_global_authorizations.
  ENDMETHOD.

  METHOD ZZ_ProvideFeedback.
  MODIFY ENTITIES OF ZRAP630I_ShopTP_sol IN LOCAL MODE
  ENTITY Shop

  UPDATE FIELDS ( zz_feedback_zaa )
  WITH VALUE #( FOR key IN keys ( %tky              = key-%tky
                                   zz_feedback_zaa  = key-%param-feedback  ) ).

    "Read the changed data for action result
    READ ENTITIES OF ZRAP630I_ShopTP_sol IN LOCAL MODE
      ENTITY Shop
        ALL FIELDS WITH
        CORRESPONDING #( keys )
      RESULT DATA(result_read).
    "return result entities
    result = VALUE #( FOR order_2 IN result_read ( %tky   = order_2-%tky
                                                   %param = order_2 ) ).
  ENDMETHOD.

ENDCLASS.
