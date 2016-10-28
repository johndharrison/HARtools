HTMLWidgets.widget({

  name: "HARviewer",
  type: "output",

  factory: function(el, width, height) {

    var elementId = el.id;
    var HARviewer =  perfCascade;
    var outputHolderEl = document.getElementById(elementId);

    return {
      renderValue: function(opts) {
        HARSvg = HARviewer.fromHar(opts.data.log, opts.options);
        outputHolderEl.appendChild(HARSvg);
      },

      resize: function(width, height) {

      },

      hv: HARviewer
    };
  }
});
