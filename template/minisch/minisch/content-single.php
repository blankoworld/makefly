<?php
/**
 * @package WordPress
 * @subpackage minisch
 */
?>

<article id="post-<?php the_ID(); ?>" <?php post_class(); ?>>

	<div class="entry-content">
		<?php the_content(); ?>
		<?php wp_link_pages( array( 'before' => '<div class="page-link">' . __( 'Pages:', 'minisch' ), 'after' => '</div>' ) ); ?>
	</div><!-- .entry-content -->

	<?php if ( get_the_author_meta( 'description' ) ) : // If a user has filled out their description and this is a multi-author blog, show a bio on their entries ?>
	<div id="author-info">
		<div id="author-avatar">
			<?php echo get_avatar( get_the_author_meta( 'user_email' ), apply_filters( 'minisch_author_bio_avatar_size', 68 ) ); ?>
		</div><!-- #author-avatar -->
		<div id="author-description">
			<h2><?php _e('About ', 'minisch'); ?><?php printf( __( '%s', 'minisch' ), get_the_author() ); ?></h2>
			<?php the_author_meta( 'description' ); ?>
			<div id="author-link">
				<a href="<?php echo esc_url( get_author_posts_url( get_the_author_meta( 'ID' ) ) ); ?>" rel="author">
					<?php _e('See all posts by ', 'minisch'); ?><?php printf( __( '%s <span class="meta-nav">&rarr;</span>', 'minisch' ), get_the_author() ); ?>
				</a>
			</div><!-- #author-link	-->
		</div><!-- #author-description -->
	</div><!-- #entry-author-info -->
	<?php endif; ?>

</article><!-- #post-<?php the_ID(); ?> -->

<?php if ( comments_open() || ( '0' != get_comments_number() && ! comments_open() ) ) : ?>
	<h1 class="entry-title">
	<?php _e('Conversation', 'minisch'); ?>
		<span class="comments-link"><?php comments_popup_link( __( '…' ), __( '1', 'minisch' ), __( '%', 'minisch' ) ); ?></span>
	</h1>
<?php endif; ?>
