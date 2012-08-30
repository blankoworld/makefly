<?php

add_action( 'admin_init', 'theme_options_init' );
add_action( 'admin_menu', 'theme_options_add_page' );

/**
 * Init plugin options to white list our options
 */
function theme_options_init(){
	register_setting( 'minisch_options', 'minisch_theme_options', 'theme_options_validate' );
}

/**
 * Load up the menu page
 */
function theme_options_add_page() {
	add_theme_page( __( 'Theme Options', 'minisch' ), __( 'Theme Options', 'minisch' ), 'edit_theme_options', 'theme_options', 'theme_options_do_page' );
}

/**
 * Create arrays for our select and radio options
 */
$select_options = array(
	'0' => array(
		'value' =>	'0',
		'label' => __( 'By default (on the left)', 'minisch' )
	),
	'1' => array(
		'value' =>	'1',
		'label' => __( 'On the right', 'minisch' )
	)
);

$radio_options = array(
	'sometime' => array(
		'value' => '0',
		'label' => __( 'By default (only for first posts of the page*, or sticky posts)', 'minisch' )
	),
	'always' => array(
		'value' => '1',
		'label' => __( 'Always', 'minisch' )
	),
	'never' => array(
		'value' => '2',
		'label' => __( 'Never', 'minisch' )
	)
);

$extraits = array(
	'0' => array(
		'value' => '0',
		'label' => __( 'By default (only for first posts of the page*, or sticky posts)', 'minisch' )
	),
	'1' => array(
		'value' => '1',
		'label' => __( 'Always', 'minisch' )
	),
	'2' => array(
		'value' => '2',
		'label' => __( 'Never', 'minisch' )
	),
	'3' => array(
		'value' => '3',
		'label' => __( 'Only on posts without Featured Image.', 'minisch' )
	)
);


/**
 * Create the options page
 */
function theme_options_do_page() {
	global $select_options, $radio_options, $extraits;

	if ( ! isset( $_REQUEST['settings-updated'] ) )
		$_REQUEST['settings-updated'] = false;
	?>

	<div class="wrap">
		<?php screen_icon(); echo "<h2>" . __( 'Theme Options', 'minisch' ) . "</h2>"; ?>

		<?php if ( false !== $_REQUEST['settings-updated'] ) : ?>
		<div class="updated fade"><p><strong><?php _e( 'Options saved !', 'minisch' ); ?></strong></p></div>
		<?php endif; ?>

		<nav style="margin: 3px 45px; font-size: 18px; line-height: 28px;">
			<?php _e('Jump to', 'minisch'); ?> : <a style="text-decoration:none;" href="#Entête">Entête &darr;</a> — <a style="text-decoration:none;" href="#Description">Description &darr;</a> — <a style="text-decoration:none;" href="#MenuDeNavigation">Menu De Navigation &darr;</a> — <a style="text-decoration:none;" href="#Articles">Articles sur les index &darr;</a> — <a style="text-decoration:none;" href="#ColonneLaterale">Colonne Latérale &darr;</a> — <a href="#PiedDePage" style="text-decoration:none;">Pied de Page &darr;</a> — <a href="#Page404" style="text-decoration:none;">Page 404 &darr;</a>.
		</nav>

		<form method="post" action="options.php">
			<?php settings_fields( 'minisch_options' ); ?>
			<?php $options = get_option( 'minisch_theme_options' ); ?>


			<table id="Entête" class="form-table">

				<caption style="font-size: 28px; padding: 17px 10px; line-height: 30px; text-align: left; border-top: 4px solid rgba(0, 0, 0, 0.1); margin-top: 25px;">Logo d'entête / Titre d'entête.</caption>

				<tr valign="top"><th scope="row"><?php _e( '<strong>Masquer l\'entête</strong>.', 'minisch' ); ?></th>
					<td>
						<input id="minisch_theme_options[nohead1]" name="minisch_theme_options[nohead1]" type="checkbox" value="1" <?php checked( '1', $options['nohead1'] ); ?> />
						<label class="description" for="minisch_theme_options[nohead1]"><?php _e( 'Masque l\'entête. (menu de navigation non-compris).', 'minisch' ); ?></label>
					</td>
				</tr>


				<tr valign="top"><th scope="row"><?php _e( '<strong>Afficher un titre</strong> dans l\'entête.', 'minisch' ); ?></th>
					<td>
						<input id="minisch_theme_options[titre1]" name="minisch_theme_options[titre1]" type="checkbox" value="1" <?php checked( '1', $options['titre1'] ); ?> />
						<label class="description" for="minisch_theme_options[titre1]"><?php _e( 'Pratique si vous n\'avez sélectionné aucun logo dans la section "<em>Apparence » En-tête</em>"<br>Si décoché, aucun texte ne s\'affichera.<br><em>Note : Pensez à décocher cette case si vous choisissez une image pour votre entête. Autrement, texte et image se superposeront.</em>', 'minisch' ); ?></label>
					</td>
				</tr>


				<tr valign="top"><th scope="row"><?php _e( '<strong>Titre</strong> pour l\'entête du site.', 'minisch' ); ?></th>
					<td>
						<input id="minisch_theme_options[titre]" class="regular-text" type="text" name="minisch_theme_options[titre]" value="<?php esc_attr_e( $options['titre'] ); ?>" >
						<label class="titre" for="minisch_theme_options[titre]"><?php _e( 'Laissez vide pour afficher le titre par défaut (choisi dans la section "Réglages » Général")', 'minisch' ); ?></label>
					</td>
				</tr>

				<tr valign="top"><th scope="row"><?php _e( '<strong>Afficher l\'entête</strong> (logo et/ou titre) <strong>sur sa propre ligne</strong>.', 'minisch' ); ?></th>
					<td>
						<input id="minisch_theme_options[titreligne1]" name="minisch_theme_options[titreligne1]" type="checkbox" value="1" <?php checked( '1', $options['titreligne1'] ); ?> />
						<label class="description" for="minisch_theme_options[titreligne1]"><?php _e( 'Fait en sorte que l\'entête (qui affiche votre logo et/ou le titre de votre blog) ne soit pas alignée avec le menu de navigation.<br>Si décoché, l\'entête sera alignée avec le menu de navigation.<br><em>Note : Si le menu de navigation contient beaucoup d\'éléments, l\'entête disposera automatiquement de sa propre ligne.</em>', 'minisch' ); ?></label>
					</td>
				</tr>
			</table>

			<p class="submit">
				<input type="submit" class="button-primary" value="<?php _e( 'Enregistrer les modifications', 'minisch' ); ?>" />
			</p>

			<table id="Description" class="form-table">

				<?php
				/**
				 * A minisch checkbox option
				 */
				?>
				<caption style="font-size: 28px; padding: 17px 10px; line-height: 30px; text-align: left; border-top: 4px solid rgba(0, 0, 0, 0.1); margin-top: 45px;">Bloc sous-titre court + description</caption>

				<tr valign="top"><th scope="row"><?php _e( '<strong>Afficher la courte description</strong>', 'minisch' ); ?></th>
					<td>
						<input id="minisch_theme_options[descrip1]" name="minisch_theme_options[descrip1]" type="checkbox" value="1" <?php checked( '1', $options['descrip1'] ); ?> />
						<label class="description" for="minisch_theme_options[descrip1]"><?php _e( 'Il s\'agit ici d\'un bloc <strong>sous-titre + description</strong>, que vous pouvez personnaliser ci-dessous.<br>Si décoché, ce bloc ne s\'affichera pas.', 'minisch' ); ?></label>
					</td>
				</tr>

				<?php
				/**
				 * A minisch text input option
				 */
				?>
				<tr valign="top"><th scope="row"><?php _e( '<strong>Sous-titre</strong> pour votre blog', 'minisch' ); ?></th>
					<td>
						<input id="minisch_theme_options[soustitre]" class="regular-text" type="text" name="minisch_theme_options[soustitre]" value="<?php esc_attr_e( $options['soustitre'] ); ?>" >
						<label class="soustitre" for="minisch_theme_options[sometext]"><?php _e( 'Affiché au sommet de la colonne latérale. Mettez-y un sous-titre court pour votre blog. (le formatage HTML est accepté).<br>Laissez vide pour afficher la description par défaut (choisie dans la section "Réglages » Général".)', 'minisch' ); ?></label>
					</td>
				</tr>


				<tr valign="top"><th scope="row"><?php _e( '<strong>Description</strong> à afficher dans la <strong>colonne latérale</strong>', 'minisch' ); ?></th>
					<td>
						<textarea style="width: 90%; height: 90px;" id="minisch_theme_options[descrip]" class="regular-text" type="text" name="minisch_theme_options[descrip]"><?php esc_attr_e( $options['descrip'] ); ?></textarea>
						<br><label class="description" for="minisch_theme_options[sometext]"><?php _e( 'Ce texte est affiché juste sous le Sous-titre entré précédemment. (le formatage HTML est accepté)', 'minisch' ); ?></label>
					</td>
				</tr>

			</table>

			<p class="submit">
				<input type="submit" class="button-primary" value="<?php _e( 'Enregistrer les modifications', 'minisch' ); ?>" />
			</p>

			<table id="MenuDeNavigation" class="form-table">
				<caption style="font-size: 28px; padding: 17px 10px; line-height: 30px; text-align: left; border-top: 4px solid rgba(0, 0, 0, 0.1); margin-top: 45px;">Menu de Navigation</caption>

				<tr valign="top"><th scope="row"><?php _e( '<strong>Masquer le Champ de Recherche</strong>', 'minisch' ); ?></th>
					<td>
						<input id="minisch_theme_options[recherche1]" name="minisch_theme_options[recherche1]" type="checkbox" value="1" <?php checked( '1', $options['recherche1'] ); ?> />
						<label class="description" for="minisch_theme_options[recherche1]"><?php _e( 'Il est intégré sur l\'extrême droite du menu.', 'minisch' ); ?></label>
					</td>
				</tr>

				<tr valign="top"><th scope="row"><?php _e( '<strong>Masquer le Bouton d\'Accueil</strong>', 'minisch' ); ?></th>
					<td>
						<input id="minisch_theme_options[home1]" name="minisch_theme_options[home1]" type="checkbox" value="1" <?php checked( '1', $options['home1'] ); ?> />
						<label class="description" for="minisch_theme_options[home1]"><?php _e( 'Peut-être n\'aimez-vous pas la petite maisonnette qui renvoie à votre page d\'accueil ?', 'minisch' ); ?></label>
					</td>
				</tr>

				<tr valign="top"><th scope="row"><?php _e( '<strong>Masquer le Bouton RSS</strong>', 'minisch' ); ?></th>
					<td>
						<input id="minisch_theme_options[rss1]" name="minisch_theme_options[rss1]" type="checkbox" value="1" <?php checked( '1', $options['rss1'] ); ?> />
						<label class="description" for="minisch_theme_options[rss1]"><?php _e( 'Ce bouton, affiché par défaut, permet aux visiteurs de s\'abonner à toutes les formes de Flux RSS/Atom disponibles, grâce à un sous-menu.', 'minisch' ); ?></label>
					</td>
				</tr>

			</table>

			<p class="submit">
				<input type="submit" class="button-primary" value="<?php _e( 'Enregistrer les modifications', 'minisch' ); ?>" />
			</p>

			<table id="Articles" class="form-table">

				<caption style="font-size: 28px; padding: 17px 10px; line-height: 30px; text-align: left; border-top: 4px solid rgba(0, 0, 0, 0.1); margin-top: 45px;">Articles sur les index</caption>

				<tr valign="top">
				<th scope="row"><?php _e( '<strong>Masquer les Images À La Une</strong>', 'minisch' ); ?></th>
					<td>
						<input id="minisch_theme_options[alaune1]" name="minisch_theme_options[alaune1]" type="checkbox" value="1" <?php checked( '1', $options['alaune1'] ); ?> />
						<label class="alaune" for="minisch_theme_options[alaune1]"><?php _e( 'Pour chacun de vos articles, vous pouvez définir une image comme étant « À la Une ». Minisch les intègre automatiquement sur les index.<br>Cochez pour ne jamais les afficher.', 'minisch' ); ?></label>
					</td>
				</tr>

				<tr valign="top"><th scope="row"><?php _e( 'Afficher l\'image à la Une ?', 'minisch' ); ?></th>
					<td>
						<fieldset><legend class="screen-reader-text"><span><?php _e( 'Image à la Une', 'minisch' ); ?></span></legend>
						<?php
							if ( ! isset( $checked ) )
								$checked = '';
							foreach ( $radio_options as $option ) {
								$radio_setting = $options['alaune2'];

								if ( '' != $radio_setting ) {
									if ( $options['alaune2'] == $option['value'] ) {
										$checked = "checked=\"checked\"";
									} else {
										$checked = '';
									}
								}
								?>
								<label class="description"><input type="radio" name="minisch_theme_options[alaune2]" value="<?php esc_attr_e( $option['value'] ); ?>" <?php echo $checked; ?> /> <?php echo $option['label']; ?></label><br />
								<?php
							}
						?>
						</fieldset>
					</td>
				</tr>

				<tr valign="top"><th scope="row"><?php _e( 'Afficher <strong>un court extrait</strong> de l\'article ?', 'minisch' ); ?></th>
					<td>
						<fieldset><legend class="screen-reader-text"><span><?php _e( 'Afficher un extrait', 'minisch' ); ?></span></legend>
						<?php
							if ( ! isset( $checked ) )
								$checked = '';
							foreach ( $extraits as $option ) {
								$radio_setting = $options['extrait'];

								if ( '' != $radio_setting ) {
									if ( $options['extrait'] == $option['value'] ) {
										$checked = "checked=\"checked\"";
									} else {
										$checked = '';
									}
								}
								?>
								<label class="description"><input type="radio" name="minisch_theme_options[extrait]" value="<?php esc_attr_e( $option['value'] ); ?>" <?php echo $checked; ?> /> <?php echo $option['label']; ?></label><br />
								<?php
							}
						?>
						</fieldset>
					</td>
				</tr>

				<tr valign="top"><th scope="row"><?php _e( '*Premiers billets', 'minisch' ); ?></th>
					<td>
						<input id="minisch_theme_options[firstp]" class="regular-text" type="text" name="minisch_theme_options[firstp]" value="<?php esc_attr_e( $options['firstp'] ); ?>" >
						<label class="firstp" for="minisch_theme_options[firstp]"><?php _e( 'Un chiffre compris entre 1 et 10 (inclus).<br>Définit le nombre de billets en tête de liste auxquels appliquer les paramètres précédents. <br>Valeur par défaut : 2', 'minisch' ); ?></label>
					</td>
				</tr>

				<tr valign="top"><th scope="row"><?php _e( 'Hauteur maximale des <strong>images à la Une</strong>.', 'minisch' ); ?></th>
					<td>
						<input id="minisch_theme_options[imhmax]" class="regular-text" type="text" name="minisch_theme_options[imgmax]" value="<?php esc_attr_e( $options['imgmax'] ); ?>" >
						<label class="imgmax" for="minisch_theme_options[imgmax]"><?php _e( 'En <strong>pixels</strong>. À entrer sous la forme <code>999px</code>.<br>Définit la <strong>hauteur maximale</strong> des images définies À la Une.<br>Valeur par défaut : 200px.', 'minisch' ); ?></label>
					</td>
				</tr>

			</table>

			<p class="submit">
				<input type="submit" class="button-primary" value="<?php _e( 'Enregistrer les modifications', 'minisch' ); ?>" />
			</p>
			<table id="ColonneLaterale" class="form-table">

				<caption style="font-size: 28px; padding: 17px 10px; line-height: 30px; text-align: left; border-top: 4px solid rgba(0, 0, 0, 0.1); margin-top: 45px;">Colonne latérale</caption>


				<tr valign="top"><th scope="row"><?php _e( '<strong>Position</strong>', 'minisch' ); ?></th>
					<td>
						<select name="minisch_theme_options[positioncolonne]">
							<?php
								$selected = $options['positioncolonne'];
								$p = '';
								$r = '';

								foreach ( $select_options as $option ) {
									$label = $option['label'];
									if ( $selected == $option['value'] ) // Make default first in list
										$p = "\n\t<option style=\"padding-right: 10px;\" selected='selected' value='" . esc_attr( $option['value'] ) . "'>$label</option>";
									else
										$r .= "\n\t<option style=\"padding-right: 10px;\" value='" . esc_attr( $option['value'] ) . "'>$label</option>";
								}
								echo $p . $r;
							?>
						</select>
						<label class="description" for="minisch_theme_options[positioncolonne]"><?php _e( ' ', 'minisch' ); ?></label>
					</td>
				</tr>


				<tr valign="top"><th scope="row"><?php _e( '<strong>Afficher la Colonne Latérale</strong> sur <strong>les pages</strong> (Articles, et Pages statiques)', 'minisch' ); ?></th>
					<td>
						<input id="minisch_theme_options[colonne1]" name="minisch_theme_options[colonne1]" type="checkbox" value="1" <?php checked( '1', $options['colonne1'] ); ?> />
						<label class="description" for="minisch_theme_options[colonne1]"><?php _e( 'Par défaut, la colonne latérale n\'est pas affichée sur les pages d\'article afin de garder le focus sur le contenu.<br>Si décoché, la colonne latérale sera masquée sur les pages d\'article.', 'minisch' ); ?></label>
					</td>
				</tr>

			</table>

			<p class="submit">
				<input type="submit" class="button-primary" value="<?php _e( 'Enregistrer les modifications', 'minisch' ); ?>" />
			</p>

			<table id="PiedDePage" class="form-table">

				<caption style="font-size: 28px; padding: 17px 10px; line-height: 30px; text-align: left; border-top: 4px solid rgba(0, 0, 0, 0.1); margin-top: 45px;">Pied de Page</caption>

				<tr valign="top"><th scope="row"><?php _e( '<strong>Masquer l\'entête</strong> du pied de page', 'minisch' ); ?></th>
					<td>
						<input id="minisch_theme_options[noheadfoot1]" name="minisch_theme_options[noheadfoot1]" type="checkbox" value="1" <?php checked( '1', $options['noheadfoot1'] ); ?> />
						<label class="description" for="minisch_theme_options[noheadfoot1]"><?php _e( 'Il hérite du même logo/titre que vous avez choisi pour <a href="#Entête">le haut de page</a>', 'minisch' ); ?></label>
					</td>
				</tr>

				<tr valign="top">
				<th scope="row"><?php _e( '<strong>Afficher les crédits</strong> dans votre pied de page.', 'minisch' ); ?></th>
					<td>
						<input id="minisch_theme_options[credits1]" name="minisch_theme_options[credits1]" type="checkbox" value="1" <?php checked( '1', $options['credits1'] ); ?> />
						<label class="credits" for="minisch_theme_options[credits1]"><?php _e( 'Dans le pied de page, vous pouvez utiliser ce bloc pour afficher vos crédits (copyright, nom, liens, informations, …). <strong>Entrez-les dans le champ ci-après.</strong><br>Si décoché, le bloc ne s\'affichera pas.', 'minisch' ); ?></label>
					</td>
				</tr>

				<tr valign="top"><th scope="row"><?php _e( '<strong>Crédits</strong> du pied de page.', 'minisch' ); ?></th>
					<td>
						<textarea style="width: 90%; height: 90px;" id="minisch_theme_options[credits]" class="regular-text" type="text" name="minisch_theme_options[credits]"><?php esc_attr_e( $options['credits'] ); ?></textarea>
						<br><label class="description" for="minisch_theme_options[credits]"><?php _e( 'Pour afficher vos crédits dans le pied de page. (le formatage HTML est accepté)', 'minisch' ); ?></label>
					</td>
				</tr>

			</table>

			<p class="submit">
				<input type="submit" class="button-primary" value="<?php _e( 'Enregistrer les modifications', 'minisch' ); ?>" />

			<table id="Page404" class="form-table">

				<caption style="font-size: 28px; padding: 17px 10px; line-height: 30px; text-align: left; border-top: 4px solid rgba(0, 0, 0, 0.1); margin-top: 45px;">Page 404</caption>

				<tr valign="top"><th scope="row"><?php _e( '<strong>Titre de la Page 404', 'minisch' ); ?></th>
					<td>
						<input id="minisch_theme_options[titre404]" class="regular-text" type="text" name="minisch_theme_options[titre404]" value="<?php esc_attr_e( $options['titre404'] ); ?>" >
						<label class="titre404" for="minisch_theme_options[titre404]"><?php _e( 'Il permettra au visiteur de se rendre directement compte qu\'il y a un problème.', 'minisch' ); ?></label>
					</td>
				</tr>

				<tr valign="top"><th scope="row"><?php _e( '<strong>Texte pour la Page 404</strong> du pied de page.', 'minisch' ); ?></th>
					<td>
						<textarea style="width: 90%; height: 90px;" id="minisch_theme_options[texte404]" class="regular-text" type="text" name="minisch_theme_options[texte404]"><?php esc_attr_e( $options['texte404'] ); ?></textarea>
						<br><label class="description" for="minisch_theme_options[texte404]"><?php _e( 'Si laissé vide, le texte par défaut s\'affichera.', 'minisch' ); ?></label>
					</td>
				</tr>
			</table>
			<p class="submit">
				<input type="submit" class="button-primary" value="<?php _e( 'Enregistrer les modifications', 'minisch' ); ?>" />
			</p>

		</form>
	</div>
	<?php
}

/**
 * Sanitize and validate input. Accepts an array, return a sanitized array.
 */
function theme_options_validate( $input ) {
	global $select_options, $radio_options;

	// Our checkbox value is either 0 or 1
	if ( ! isset( $input['titre1'] ) )
		$input['titre1'] = null;
	$input['titre1'] = ( $input['titre1'] == 1 ? 1 : 0 );

	// Our checkbox value is either 0 or 1
	if ( ! isset( $input['descrip1'] ) )
		$input['descrip1'] = null;
	$input['descrip1'] = ( $input['descrip1'] == 1 ? 1 : 0 );

	// Our checkbox value is either 0 or 1
	if ( ! isset( $input['nohead1'] ) )
		$input['nohead1'] = null;
	$input['nohead1'] = ( $input['nohead1'] == 1 ? 1 : 0 );

	// Our checkbox value is either 0 or 1
	if ( ! isset( $input['noheadfoot1'] ) )
		$input['noheadfoot1'] = null;
	$input['noheadfoot'] = ( $input['noheadfoot'] == 1 ? 1 : 0 );

	// Our checkbox value is either 0 or 1
	if ( ! isset( $input['titreligne1'] ) )
		$input['titreligne1'] = null;
	$input['titreligne1'] = ( $input['titreligne1'] == 1 ? 1 : 0 );

	// Our checkbox value is either 0 or 1
	if ( ! isset( $input['colonne1'] ) )
		$input['colonne1'] = null;
	$input['colonne1'] = ( $input['colonne1'] == 1 ? 1 : 0 );

	// Our checkbox value is either 0 or 1
	if ( ! isset( $input['recherche1'] ) )
		$input['recherche1'] = null;
	$input['recherche1'] = ( $input['recherche1'] == 1 ? 1 : 0 );

	// Our checkbox value is either 0 or 1
	if ( ! isset( $input['rss1'] ) )
		$input['rss1'] = null;
	$input['rss1'] = ( $input['rss1'] == 1 ? 1 : 0 );

	// Our checkbox value is either 0 or 1
	if ( ! isset( $input['home1'] ) )
		$input['home1'] = null;
	$input['home1'] = ( $input['home1'] == 1 ? 1 : 0 );

	// Our checkbox value is either 0 or 1
	if ( ! isset( $input['alaune1'] ) )
		$input['alaune1'] = null;
	$input['alaune1'] = ( $input['alaune1'] == 1 ? 1 : 0 );

	// Our checkbox value is either 0 or 1
	if ( ! isset( $input['credits1'] ) )
		$input['credits1'] = null;
	$input['credits1'] = ( $input['credits1'] == 1 ? 1 : 0 );

	// Say our text option must be safe text with no HTML tags
	$input['sometext'] = wp_filter_nohtml_kses( $input['sometext'] );

	// Our select option must actually be in our array of select options
	if ( ! array_key_exists( $input['selectinput'], $select_options ) )
		$input['selectinput'] = null;

	// Our radio option must actually be in our array of radio options
	if ( ! isset( $input['radioinput'] ) )
		$input['radioinput'] = null;
	if ( ! array_key_exists( $input['radioinput'], $radio_options ) )
		$input['radioinput'] = null;

	// Say our textarea option must be safe text with the allowed tags for posts
	$input['sometextarea'] = wp_filter_post_kses( $input['sometextarea'] );

	return $input;
}

// adapted from http://planetozh.com/blog/2009/05/handling-plugins-options-in-wordpress-28-with-register_setting/
