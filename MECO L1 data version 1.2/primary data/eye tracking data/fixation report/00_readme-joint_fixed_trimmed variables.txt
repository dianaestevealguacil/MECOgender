This is a description of variables used in the MECO L1 fixation report, release 1, version 1.2.

subid: Do NOT use this variable. Use 'uniform_id' instead. 
trialid: Position of trial (text) in experiment: 1-12
itemid: Do NOT use this variable - use 'trialid' instead.
cond: Condition - not applicable here.
fixid: Number of fixation in a trial
start: Start time (in ms since start of the trial)
stop: End time (in ms since start of the trial)
xs: Raw x position (in pixel)
ys: Raw y position (in pixel)
xn: Corrected x position (in pixel), i.e. after drift correction and line assignment
yn: Corrected y position (in pixel), i.e. after drift correction and line assignment
ym: Mean y position (position of the line)
dur: Duration
sac.in: Incoming saccade length (in letters)
sac.out: Outgoing saccade length (in letters)
type: Whether fixation is an outlier fixation ("out"), i.e. located outside the text area (see assign.outlier and assign.outlier.dist arguments)
blink: Whether a blink occured directly before or after the fixation
run: Number of run the fixation was assigned to (if applicable)
linerun: Number of run on the line the fixation was assigned to (if applicable)
line: Number of line the fixation was assigned to
line.change: Difference between the line of the current and the last fixation
line.let: Number of letter on line
line.word: Number of word on line
letternum: Number of letter in trial
letter: Name of Letter
wordnum: Number of word in trial
word: Name of Word
ianum: Number of IA in trial
ia: Name of IA
sentnum: Number of sentence in trial
sent: Name of sent (abbreviated)
sent.nwords: Number of words in sentence
trial: Name trial (abbreviated)
trial.nwords: Number of words in trial
word.fix: Number of fixation on word
word.run: Number of run the word the word was read
word.runid: Number of the word run, the fixation belongs to
word.run.fix: Number of fixation within the run
word.firstskip: Whether word has been skipped during first-pass reading
word.refix: Whether word has been refixated with current fixation
word.launch: Launch site distance from the beginning of the word
word.land: Landing position with word
word.cland: Centered landing position (e.g., calculated from the center of the word)
word.reg.out: Whether a regression was made out of the word
word.reg.in: Whether a regression was made into the word
ia.fix: Number of fixation on IA
ia.run: Number of run the word the IA was read
ia.runid: Number of the IA run, the fixation belongs to
ia.run.fix: Number of fixation within the run
ia.firstskip: Whether IA has been skipped during first-pass reading
ia.refix: Whether IA has been refixated with current fixation
ia.launch: Launch site distance from the beginning of the IA
ia.land: Landing position with IA
ia.cland: Centered landing position (e.g., calculated from the center of the IA)
ia.reg.out: Whether a regression was made out of the IA
ia.reg.in: Whether a regression was made into the IA
sent.word: Number of word in sentence
sent.fix: Number of fixation on sentence
sent.run: Number of run on sentence
sent.runid: Number of the sentence run, the fixation belongs to
sent.firstskip: Whether the sentence has been skipped during first-pass reading
sent.refix: Whether sentence was refixated wither current fixation
sent.reg.out: Whether a regression was made out the sentence
sent.reg.in: Whether a regression was made into the sentence
lang: language code - du: Dutch; ee: Estonian; en: English; fi: Finnish; ge: German; gr: Greek; he: Hebrew; it: Italian; ko: Korean; no: Norwegian; ru: Russian; sp: Spanish; tr: Turkish.
trial: do NOT use. Use 'trialid' instead.
supplementary_id: do NOT use. Use 'uniform_id' instead.
uniform_id: Participant ID. Please use this variable in all analyses in order to merge different data frames. 

