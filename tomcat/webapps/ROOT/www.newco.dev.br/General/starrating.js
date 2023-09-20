/*
 * jQuery StarRating plugin
 */
;(function($) {
	function StarRating(options) {
		this.options = $.extend({
			stars: 'ul li',
			input: 'input[type=hidden]',
			label: '.rating span',
			ratedClass: '',
			selectedClass: 'active',
			emptyClass: ''
		}, options);
		this.init();
	}
	StarRating.prototype = {
		init: function() {
			if (this.options.holder) {
				this.findElements();
				this.attachEvents();
				this.makeCallback('onInit', this);
			}
		},
		findElements: function() {
			this.holder = $(this.options.holder);
			this.stars = this.holder.find(this.options.stars);
			this.input = this.holder.find(this.options.input);
			this.label = this.holder.find(this.options.label);

			if (this.input.length) {
				this.updateRating(this.input.val() || 0);
			}
		},
		attachEvents: function() {
			// add handler
			var self = this;

			self.stars.on('click', function(event)
			{
				event.preventDefault();

				var value = self.stars.index(this);

				if (value != -1) {
					self.updateRating(++value);

					if (self.input.length)
						self.input.val(value);
				}
			});

			if (self.input.length) {
				self.stars.on('mouseenter', function(event)
				{
					var value = self.stars.index(this);

					if (value != -1)
						self.updateRating(++value);
				});

				self.stars.on('mouseout', function(event)
				{
					self.updateRating(self.input.val());
				});
			}
		},
		updateRating: function(value) {
			var self = this;

			self.stars.each(function(index, star)
			{
				if (index < value) {
					$(star).removeClass(self.options.emptyClass)
					       .addClass(self.options.selectedClass);
				}
				else {
					$(star).removeClass(self.options.selectedClass)
					       .addClass(self.options.emptyClass);
				}
			});


			if (value > 0) {
				self.holder.addClass(self.options.ratedClass);
			}
			else {
				self.holder.removeClass(self.options.ratedClass);
			}

			self.label.html(value || 0);

			self.makeCallback('updateRating', true);
		},
		makeCallback: function(name) {
			if(typeof this.options[name] === 'function') {
				var args = Array.prototype.slice.call(arguments);
				args.shift();
				this.options[name].apply(this, args);
			}
		}
	};

	// jQuery plugin interface
	$.fn.starRating = function(opt) {
		return this.each(function() {
			jQuery(this).data('StarRating', new StarRating($.extend(opt, {holder: this})));
		});
	};
}(jQuery));
