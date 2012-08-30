<?php
/**
 * The template for displaying the footer.
 *
 * Contains the closing of the id=main div and all content after
 *
 * @package WordPress
 * @subpackage minisch
 * @since minisch 0.1
 */
?>

<?php wp_footer(); ?>

</div> <!-- CONTENEUR -->

	<footer id="lamochebarre">
		<section>
		<?php $options = get_option('minisch_theme_options'); ?>
		<?php if ( $options['noheadfoot1'] ) : ?>
		<?php else : ?>
			<a class="accueil" href="<?php echo get_option('home'); ?>">

				<?php $options = get_option('minisch_theme_options'); ?>
				<?php if ( $options['titre1'] ) : ?>

					<?php if ( $options['titre'] ) : ?>
						<?php
						    $options = get_option('minisch_theme_options');
						    echo $options['titre'];
			      			?>
					<?php else : ?>
						<?php bloginfo('name'); ?>
					<?php endif; ?>

				<?php endif; ?>
			</a>
		<?php endif; ?>


		<?php $options = get_option('minisch_theme_options'); ?>
		<?php if ( $options['credits1'] ) : ?>
			<span class="credits">
				<?php if ( $options['credits'] ) : ?>
					<?php echo $options['credits']; ?>
				<?php else : ?>
					<?php _e('Proudly powered by', 'minisch'); ?> <a href="http://wordpress.org">Wordpress.org</a>.
				<?php endif; ?>
			</span>
		<?php endif; ?>
		</section>

		<?php if ( is_active_sidebar( 'footer-2' ) ) : ?>
		<div id="tertiary" class="widget-area" role="complementary">
			<?php dynamic_sidebar( 'footer-2' ); ?>
		</div><!-- #tertiary .widget-area -->
		<?php endif; ?>
	</footer>

</body>
</html>
