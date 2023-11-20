extend view entity ZRAP630C_ShopTP_SOL with {
     @UI.lineItem: [ {
    position: 140 , 
    importance: #MEDIUM, 
    label: 'Feedback'
    } ,
      { type: #FOR_ACTION, dataAction: 'ZZ_ProvideFeedback', label: 'Update feedback' } ]
    @UI.identification: [ {
    position: 140 , 
    label: 'Feedback'
    } ]
  
    Shop.zz_feedback_zaa as zz_feedback_zaa  

}
