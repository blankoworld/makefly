<?php
/**
 * The Sidebar containing the main widget areas.
 *
 * @package WordPress
 * @subpackage minisch
 * @since minisch 0.1
 */
?>
	 <aside id="laterale">
		<div>
	 		<a class="toggle laterale open" href="#laterale">
				<strong>&rarr; </strong><?php _e('Sidebar', 'minisch'); ?></a>
	 		<a class="toggle laterale close" href="#">
				<strong>&larr; </strong><?php _e('Close', 'minisch'); ?></a>
		</div>

		<?php $options = get_option('minisch_theme_options'); ?>
		<?php if ( $options['descrip1'] ) : ?>

			<header style="" id="descrip">
			<?php if ( $options['soustitre'] ) : ?>
             	     		<?php
				    $options = get_option('minisch_theme_options');
				    echo $options['soustitre'];
				?><br>
			<?php else : ?>
				<?php bloginfo('description'); ?>
			<?php endif; ?>
					<p><?php
					    $options = get_option('minisch_theme_options');
					    echo $options['descrip'];
					?></p>
           	        </header>

		<?php endif; ?>

		<?php if ( ! dynamic_sidebar( 'sidebar-1' ) ) : ?>
				<aside id="archives" class="widget">
					<h3 class="widget-title"><?php _e( 'Archives', 'twentyeleven' ); ?></h3>
					<ul>
						<?php wp_get_archives( array( 'type' => 'monthly' ) ); ?>
					</ul>
				</aside>

				<aside id="meta" class="widget">
					<h3 class="widget-title"><?php _e( 'Meta', 'twentyeleven' ); ?></h3>
					<ul>
						<?php wp_register(); ?>
						<li><?php wp_loginout(); ?></li>
						<?php wp_meta(); ?>
					</ul>
				</aside>
		<?php endif; // end sidebar widget area ?>
		</aside><!-- #secondary .widget-area -->
