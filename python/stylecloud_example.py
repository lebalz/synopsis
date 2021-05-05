import stylecloud


LEITBILD = '''
Leitbild
Präambel
Das Gymnasium Biel-Seeland umfasst drei Abteilungen: Gymnasium, Fachmittelschule und 
Wirtschaftsmittelschule. In allen Abteilungen wird umfassende Bildung als Grundlage für Studium, Beruf und 
Leben vermittelt. Leistungsbereitschaft und der Wille, die Schule mitzugestalten, werden erwartet.
1. selbständig, reflektiert, kompetent
Bei uns stehen das Interesse an unterschiedlichen Themen sowie eine engagierte und vertiefte
Auseinandersetzung mit den Lerninhalten im Zentrum.
Wir fördern Selbständigkeit, Selbstverantwortung und Reflexion über eigene Stärken und Schwächen. 
Wir begleiten und beraten während des Lernprozesses und pflegen den gegenseitigen Austausch. 
2. analytisch, kritisch, kreativ 
Wir regen an, unterschiedliche Perspektiven einzunehmen und diese rational und wissenschaftsbasiert zu 
begründen. Wir schaffen den Rahmen für das Neben- und Miteinander von Kunst und Wissenschaft, von 
analytischem Denken und Kreativität.
3. gestalten, entfalten, sich engagieren
Wir schaffen Gelegenheiten, bei denen jeder mitgestalten und sich entfalten kann. 
Wir unterstützen Engagement, das über den Unterricht hinausgeht. 
Wir bringen die nötige Flexibilität gegenüber Jugendlichen mit besonderer Begabung auf, um das Nebeneinander 
von Schule und Talent zu ermöglichen.
4. begegnen, bereichern, Brücken schlagen
Alle Menschen an unserer Schule haben dieselben Chancen. Der Austausch ist für uns eine Bereicherung und 
eine Möglichkeit, die eigene Position zu hinterfragen. 
5. Vertrauen, Verbindlichkeit, Verständnis
Wir kommunizieren fair, transparent und rechtzeitig. 
Wir schaffen den passenden Rahmen, wo wir einander zuhören und einander ausreden lassen. 
Bei Unklarheiten fragen wir nach und suchen gemeinsam nach Lösungen. An Abmachungen halten wir uns. 
6. Biel, Bienne, bilingue 
Wir profitieren von der Zweisprachigkeit des Standorts Biel-Bienne und pflegen den Kontakt zur anderen Sprachund Kulturgruppe. Wir pflegen den Austausch mit Institutionen der Region. 
7. nachhaltig, vorbildlich, weitsichtig
Wir legen Wert auf einen verantwortungsvollen und nachhaltigen Umgang mit unseren Ressourcen und unserer 
Umwelt. Wir achten darauf, dass unser Verhalten andere nicht beeinträchtigt. Wir tragen Sorge zu den Gebäuden 
und Räumlichkeiten, der Einrichtung und dem Schulmaterial. 
8. mitreden, mitmachen, mitwirken
Wir legen Wert auf konstruktives Mitwirken und Eigenverantwortung. 
Kritik- und Teamfähigkeit, Toleranz und ein friedliches Miteinander sowie weltoffenes Denken prägen unser 
Handeln
'''

stylecloud.gen_stylecloud(
    text=LEITBILD,
    custom_stopwords=[
        'und', 'zu', 'von', 'an', 'bei',
        'den', 'des', 'eine', 'ein', 'auf',
        'der', 'das', 'die',
        'mit', 'für', 'uns', 'wir', 'über'
    ],
    icon_name='fas fa-graduation-cap',

)
