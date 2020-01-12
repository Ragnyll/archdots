require 'cairo'

function conky_main()
    if conky_window == nil then
        return
    end
    local cs = cairo_xlib_surface_create (conky_window.display,
                                         conky_window.drawable,
                                         conky_window.visual,
                                         conky_window.width,
                                         conky_window.height)
    cr = cairo_create(cs)

	gaugue_props = {
		gaugue_name = "cpu",
		gaugue_value = conky_parse("${cpu}"),
		gaugue_max = 100,
		orientation = "right",
		colors = {
			free_color = { -- dark_grey
				r = 35.9,
				g = 34.9,
				b = 36.9,
				a = .1
			},
			used_color = { -- light_grey
				r = 52.9,
				g = 51.3,
				b = 54.6,
				a = .6
			},
			rule_color = { -- light_grey less transparency
				r = 52.9,
				g = 51.3,
				b = 54.6,
				a = .5
			}
		},
		meter = {
			x = 200, -- the center x offset relative to conf bottom left
			y = 200, -- the center y offset relative to conf bottom left
			r = 50,  -- the radius of the guage
			w = 4    -- the width of the stroke
		},
		rule = {
			w = 3,
			l = 285
		}
	}

	-- draw the cpu_indicator
	ring_gaugue(cr, gaugue_props)

    cairo_destroy(cr)
    cairo_surface_destroy(cs)
    cr = nil
end

function ring_gaugue(cr, gaugue_props)
	-- draws a ring gaugue
	-- cr: cairo created surface
	-- gaugue_props: table containing colors (free and used), a meter table, and gaugue metadata
	-- draw_rule: boolean to tell whether to draw a rule connecting the ring to the oriented edge of the cairo space

	if(gaugue_props.rule ~= nil) then
		draw_rule(cr, gaugue_props)
	end
	draw_free_ring(cr, gaugue_props)
	draw_used_ring(cr, gaugue_props)
end

function draw_rule(cr, gaugue_props)
	-- draws a rule from the top middle of the circle to the edge of the cairo space the gaugue is oriented to
	-- gaugue_props: the gaugue table containing the rule table

	-- find top center of ring and connect the rule to it at a 45 degree angle (its not really a 45 degree angle. I dont feel like calculating that atm)
	tangent_x = gaugue_props.meter.x
	tangent_y = gaugue_props.meter.y - gaugue_props.meter.r - (gaugue_props.meter.w / 2)
	end_x, end_y = tangent_x + 25, tangent_y - 25
	cairo_set_source_rgba(cr, gaugue_props.colors.rule_color.r, gaugue_props.colors.rule_color.g, gaugue_props.colors.rule_color.b, gaugue_props.colors.rule_color.a)
	cairo_set_line_width(cr, gaugue_props.rule.w)
	cairo_set_line_cap(cr, CAIRO_LINE_CAP_ROUND)
	cairo_move_to(cr, tangent_x, tangent_y)
	cairo_line_to(cr, end_x, end_y)
	cairo_stroke(cr)

	-- find the end coordinate of the connector rule and draw another rule connecting it to the edge of the screen (note this value is estimated as there is no way (i know of) to get the size of the cairo space
	cairo_move_to(cr, end_x, end_y)
	cairo_line_to(cr, end_x + gaugue_props.rule.l, end_y)
	cairo_stroke(cr)
end

function draw_free_ring(cr, ring_props)
	-- draws a dark gray ring
	-- cr: cairo created surface
	-- ring_props: table containing colors (free and used), a meter table, and gaugue metadata

	start_angle, end_angle = 0, (2 * math.pi)
	cairo_set_source_rgba(cr, ring_props.colors.free_color.r, ring_props.colors.free_color.g, ring_props.colors.free_color.b, ring_props.colors.free_color.a)
	cairo_set_line_width(cr, ring_props.meter.w)
	cairo_arc(cr, ring_props.meter.x, ring_props.meter.y, ring_props.meter.r, start_angle, end_angle)
	cairo_stroke(cr)
end

function draw_used_ring(cr, ring_props)
	-- draws a light circle indicating amount of resource used
	-- cr: cairo created surface
	-- ring_props: table containing colors (free and used), a meter table, and gaugue metadata

	-- move arc_indicator
	end_angle = ring_props.gaugue_value * (360 / ring_props.gaugue_max)

	cairo_set_source_rgba(cr, ring_props.colors.used_color.r, ring_props.colors.used_color.g, ring_props.colors.used_color.b, ring_props.colors.used_color.a)
	cairo_set_line_width(cr, ring_props.meter.w)
	-- angles in cairo are drawn from pi (90 deg) they must be offset to start from top
	cairo_arc(cr, ring_props.meter.x, ring_props.meter.y, ring_props.meter.r, degrees_to_radians(-90), degrees_to_radians(end_angle - 90))
	cairo_stroke(cr)
end

function degrees_to_radians(degrees)
	return degrees * (math.pi / 180)
end
