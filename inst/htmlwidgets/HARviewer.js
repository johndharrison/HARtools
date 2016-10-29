HTMLWidgets.widget({

  name: "HARviewer",
  type: "output",

  factory: function(el, width, height) {

    var elementId = el.id;
    var HARviewer =  perfCascade;
    var outputHolderEl = document.getElementById(elementId);
    var pageSelectorEl = document.getElementById("page-selector");

    return {
      renderValue: function(opts) {
        newopts = opts;
        newopts.options.pageSelector = pageSelectorEl;
        HARSvg = HARviewer.fromHar(newopts.data.log, newopts.options);
        outputHolderEl.appendChild(HARSvg);
      },

      resize: function(width, height) {

      },

      hv: HARviewer
    };
  }
});
