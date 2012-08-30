<?php
/**
 * Template Name: Archives
 * Description: archives
 *
 * @package WordPress
 * @subpackage Twenty_Eleven
 * @since Twenty Eleven 1.0
 */

get_header(); ?>

	<section id="flux">
		<?php if ( ! dynamic_sidebar( 'archives' ) ) : ?>
		<section class="widget">
			<h1 class="widget-title"><?php _e( 'Time Machine', 'minisch' ); ?></h1>
			<ul>
				<?php wp_get_archives('type=monthly'); ?>
			</ul>
		</section>
		<section class="widget widget_tag_cloud">
			<h1 class="widget-title"><?php _e( 'Even more tags', 'minisch' ); ?></h1>
			<div>
				<?php wp_tag_cloud('number=60&smallest=12&largest=30'); ?>
			</div>
		</section>
		<section class="widget">
			<h1 class="widget-title"><?php _e( 'All Categories', 'minisch' ); ?></h1>
			<ul>
				<?php wp_list_categories('orderby=ID&hide_empty=true&depth=3&hierarchical=true&title_li='); ?>
			</ul>
		</section>
		<?php endif; // end sidebar widget area ?>

	</section>

<?php get_footer(); ?>
